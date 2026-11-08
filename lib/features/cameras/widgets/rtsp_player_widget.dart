import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../core/config/cyberdeck_config_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cyber_tap_target.dart';
import '../models/rtsp_camera_model.dart';
import '../providers/cameras_provider.dart';
import 'camera_modal_dialog.dart';

class RtspPlayerWidget extends ConsumerStatefulWidget {
  final RtspCameraModel camera;
  final bool isFullscreen;

  const RtspPlayerWidget({
    super.key,
    required this.camera,
    this.isFullscreen = false,
  });

  @override
  ConsumerState<RtspPlayerWidget> createState() => _RtspPlayerWidgetState();
}

class _RtspPlayerWidgetState extends ConsumerState<RtspPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';
  Timer? _tickerTimer;
  Timer? _watchdogTimer;
  Timer? _reconnectDelayTimer;
  DateTime _now = DateTime.now();

  // Watchdog and Auto-reconnection state
  bool _isAutoReconnecting = false;
  int _reconnectAttempts = 0;

  @override
  void initState() {
    super.initState();
    _startTicker();
    _startWatchdog();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(covariant RtspPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.camera.url != widget.camera.url || oldWidget.camera.id != widget.camera.id) {
      _reconnectAttempts = 0;
      _initializePlayer();
    } else if (oldWidget.camera.isMuted != widget.camera.isMuted) {
      _controller?.setVolume(widget.camera.isMuted ? 0.0 : 1.0);
    }
  }

  void _startTicker() {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  /// Watchdog that inspects stream health:
  /// Watchdog that inspects stream health:
  /// Detects fatal controller errors and dropped sockets to trigger recovery.
  void _startWatchdog() {
    _watchdogTimer?.cancel();
    _watchdogTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _isAutoReconnecting) return;
      final controller = _controller;
      if (controller == null) return;

      // Check for player error
      if (controller.value.hasError) {
        _triggerAutoReconnect(reason: controller.value.errorDescription ?? 'Error de decodificación RTSP');
        return;
      }
    });
  }

  Future<void> _triggerAutoReconnect({required String reason}) async {
    if (_isAutoReconnecting || !mounted) return;
    _isAutoReconnecting = true;
    _reconnectAttempts++;

    ref.read(cyberdeckConfigProvider.notifier).logAction(
          'SURV',
          'WATCHDOG ${widget.camera.name}: $reason -> AUTO-RECONEXIÓN #$_reconnectAttempts',
        );

    setState(() {
      _errorMessage = '$reason (Reintentando #$_reconnectAttempts)';
    });

    _disposePlayer();

    // Incremental backoff: 1.5s, 2.5s, up to 4s
    final delayMs = _reconnectAttempts == 1 ? 1500 : (_reconnectAttempts < 4 ? 2500 : 4000);

    _reconnectDelayTimer?.cancel();
    _reconnectDelayTimer = Timer(Duration(milliseconds: delayMs), () {
      if (mounted) {
        _initializePlayer(isRetry: true);
      }
    });
  }

  Future<void> _initializePlayer({bool isRetry = false}) async {
    _reconnectDelayTimer?.cancel();
    _disposePlayer();
    if (mounted) {
      setState(() {
        _isInitialized = false;
        if (!isRetry) {
          _hasError = false;
          _errorMessage = '';
          _reconnectAttempts = 0;
        }
      });
    }

    try {
      final uri = Uri.parse(widget.camera.url.trim());
      final controller = VideoPlayerController.networkUrl(
        uri,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _controller = controller;
      controller.addListener(_onPlayerStateChanged);

      await controller.initialize().timeout(const Duration(seconds: 10));
      await controller.setVolume(widget.camera.isMuted ? 0.0 : 1.0);
      await controller.play();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
          _errorMessage = '';
          _isAutoReconnecting = false;
          _reconnectAttempts = 0;
        });

        if (isRetry) {
          ref.read(cyberdeckConfigProvider.notifier).logAction(
                'SURV',
                'WATCHDOG ${widget.camera.name}: ENLACE RESTABLECIDO Y FLUIDO (TCP)',
              );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
        // Schedule next automatic retry if not yet connected
        _triggerAutoReconnect(reason: 'Fallo al inicializar: $e');
      }
    }
  }

  void _onPlayerStateChanged() {
    if (!mounted) return;
    final controller = _controller;
    if (controller == null) return;

    if (controller.value.hasError && !_isAutoReconnecting) {
      _triggerAutoReconnect(reason: controller.value.errorDescription ?? 'Error en stream RTSP');
    } else if (mounted) {
      setState(() {});
    }
  }

  void _disposePlayer() {
    _controller?.removeListener(_onPlayerStateChanged);
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _watchdogTimer?.cancel();
    _reconnectDelayTimer?.cancel();
    _disposePlayer();
    super.dispose();
  }

  void _toggleAudio() {
    final newMute = !widget.camera.isMuted;
    ref.read(camerasProvider.notifier).toggleMute(widget.camera.id);
    _controller?.setVolume(newMute ? 0.0 : 1.0);
    ref.read(cyberdeckConfigProvider.notifier).logAction(
          'SURV',
          'AUDIO ${widget.camera.name} -> ${newMute ? "MUTED [SILENCIADO]" : "LIVE [ACTIVO]"}',
        );
  }

  void _togglePlayPause() {
    final controller = _controller;
    if (controller == null) return;
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  void _toggleStreamProfile() {
    final currentPath = widget.camera.path;
    String newPath = currentPath;

    if (currentPath.contains('ch00_0')) {
      newPath = currentPath.replaceAll('ch00_0', 'ch00_1');
    } else if (currentPath.contains('ch00_1')) {
      newPath = currentPath.replaceAll('ch00_1', 'ch00_0');
    } else if (currentPath.contains('/101')) {
      newPath = currentPath.replaceAll('/101', '/102');
    } else if (currentPath.contains('/102')) {
      newPath = currentPath.replaceAll('/102', '/101');
    } else if (currentPath.contains('subtype=0')) {
      newPath = currentPath.replaceAll('subtype=0', 'subtype=1');
    } else if (currentPath.contains('subtype=1')) {
      newPath = currentPath.replaceAll('subtype=1', 'subtype=0');
    } else {
      newPath = '/live/ch00_1';
    }

    final newUrl = widget.camera.user.isNotEmpty
        ? 'rtsp://${widget.camera.user}:${widget.camera.password}@${widget.camera.ip}:${widget.camera.port}$newPath'
        : 'rtsp://${widget.camera.ip}:${widget.camera.port}$newPath';

    final updated = widget.camera.copyWith(
      path: newPath,
      url: newUrl,
    );

    ref.read(camerasProvider.notifier).updateCamera(updated);
    ref.read(cyberdeckConfigProvider.notifier).logAction(
          'SURV',
          'STREAM PROFILE ${widget.camera.name}: CAMBIADO A $newPath',
        );
  }

  void _openFullscreen(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.95),
      builder: (ctx) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: RtspPlayerWidget(
          camera: widget.camera,
          isFullscreen: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;
    final secondary = config.secondaryAccent;
    final timeStr = DateFormat('HH:mm:ss').format(_now);

    final isLiveActive = _isInitialized && _controller != null && !_hasError && !_isAutoReconnecting;
    final isSubStream = widget.camera.path.contains('ch00_1') ||
        widget.camera.path.contains('/102') ||
        widget.camera.path.contains('subtype=1');

    return RepaintBoundary(
      child: Container(
        height: widget.isFullscreen ? double.infinity : 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(widget.isFullscreen ? 0 : 4),
          border: Border.all(
            color: accent.withValues(alpha: widget.isFullscreen ? 0.8 : 0.4),
            width: widget.isFullscreen ? 2.0 : 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.isFullscreen ? 0 : 3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Video Layer or Fallback Placeholder
              if (isLiveActive)
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio > 0 ? _controller!.value.aspectRatio : 16 / 9,
                    child: VideoPlayer(_controller!),
                  ),
                )
              else if (_isAutoReconnecting)
                _buildAutoReconnectingHud(config, accent, secondary)
              else if (_hasError)
                _buildOfflineHud(config, accent, secondary)
              else
                _buildBufferingHud(config, accent, secondary),

              // 2. Cyberdeck Tactical HUD Reticle Overlay
              if (config.enableVisualEffects)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _SurveillanceReticlePainter(accentColor: accent),
                    ),
                  ),
                ),

              // 3. Top HUD Status Bar
              Positioned(
                top: 8,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Camera Tag & IP badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: accent.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.videocam, size: 14, color: accent),
                          const SizedBox(width: 5),
                          Text(
                            widget.camera.name,
                            style: AppTheme.mono(fontSize: 10.5, fontWeight: FontWeight.bold, color: accent),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '[${widget.camera.ip}:${widget.camera.port}]',
                            style: AppTheme.mono(fontSize: 9.5, color: secondary),
                          ),
                        ],
                      ),
                    ),

                    // Live REC / Reconnecting Status LED & Timecode
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: isLiveActive
                                  ? AppTheme.phosphorGreen
                                  : (_isAutoReconnecting ? AppTheme.amberAlert : AppTheme.error),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isLiveActive
                                      ? AppTheme.phosphorGreen
                                      : (_isAutoReconnecting ? AppTheme.amberAlert : AppTheme.error),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isLiveActive
                                    ? 'REC // LIVE (TCP)'
                                    : (_isAutoReconnecting ? 'AUTO-RECONECTANDO (#$_reconnectAttempts)' : 'SYNC'),
                                style: AppTheme.mono(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: isLiveActive
                                      ? AppTheme.phosphorGreen
                                      : (_isAutoReconnecting ? AppTheme.amberAlert : AppTheme.error),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                timeStr,
                                style: AppTheme.mono(fontSize: 9.5, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        if (widget.isFullscreen) ...[
                          const SizedBox(width: 8),
                          CyberTapTarget(
                            onTap: () => Navigator.pop(context),
                            pressColor: AppTheme.error,
                            tooltip: 'Cerrar pantalla completa',
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.error.withValues(alpha: 0.5)),
                              ),
                              child: const Icon(Icons.close, size: 16, color: AppTheme.error),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // 4. Bottom HUD Controls Bar
              Positioned(
                bottom: 8,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    // Codec / Stream details + Quick Profile Switcher
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Text(
                                'RTSP // ${widget.camera.path}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.mono(fontSize: 8.5, color: AppTheme.textSecondary),
                              ),
                            ),
                          ),
                          CyberTapTarget(
                            onTap: _toggleStreamProfile,
                            tooltip: isSubStream ? 'Cambiar a Main Stream (HD / Alta Resolución)' : 'Cambiar a Sub Stream (Fluido / Bajo Consumo)',
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSubStream ? accent.withValues(alpha: 0.15) : secondary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: isSubStream ? accent.withValues(alpha: 0.7) : secondary.withValues(alpha: 0.7),
                                ),
                              ),
                              child: Text(
                                isSubStream ? 'SUB [FLUIDO]' : 'MAIN [HD]',
                                style: AppTheme.mono(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  color: isSubStream ? accent : secondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Interactive Controls Row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Audio Mute / Unmute Button
                        CyberTapTarget(
                          onTap: _toggleAudio,
                          pressColor: widget.camera.isMuted ? secondary : accent,
                          tooltip: widget.camera.isMuted ? 'Activar Audio (Escuchar)' : 'Silenciar Audio',
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: widget.camera.isMuted ? secondary.withValues(alpha: 0.6) : accent,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  widget.camera.isMuted ? Icons.volume_off : Icons.volume_up,
                                  size: 14,
                                  color: widget.camera.isMuted ? secondary : accent,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.camera.isMuted ? 'SILENCIADO' : 'AUDIO EN VIVO',
                                  style: AppTheme.mono(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: widget.camera.isMuted ? secondary : accent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Play / Pause Toggle
                        CyberTapTarget(
                          onTap: _togglePlayPause,
                          pressColor: accent,
                          tooltip: _controller?.value.isPlaying == true ? 'Pausar stream' : 'Reanudar stream',
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: accent.withValues(alpha: 0.5)),
                            ),
                            child: Icon(
                              _controller?.value.isPlaying == true ? Icons.pause : Icons.play_arrow,
                              size: 15,
                              color: accent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Reconnect / Refresh Button
                        CyberTapTarget(
                          onTap: () {
                            _reconnectAttempts = 0;
                            _initializePlayer();
                          },
                          pressColor: secondary,
                          tooltip: 'Reiniciar enlace RTSP',
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: secondary.withValues(alpha: 0.5)),
                            ),
                            child: Icon(Icons.refresh, size: 15, color: secondary),
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Edit Camera Config Button
                        CyberTapTarget(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => CameraModalDialog(camera: widget.camera),
                            );
                          },
                          pressColor: secondary,
                          tooltip: 'Editar parámetros de cámara',
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: secondary.withValues(alpha: 0.5)),
                            ),
                            child: Icon(Icons.tune, size: 15, color: secondary),
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Fullscreen Toggle Button
                        if (!widget.isFullscreen)
                          CyberTapTarget(
                            onTap: () => _openFullscreen(context),
                            pressColor: accent,
                            tooltip: 'Pantalla completa',
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: accent.withValues(alpha: 0.5)),
                              ),
                              child: Icon(Icons.fullscreen, size: 15, color: accent),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutoReconnectingHud(CyberdeckConfig config, Color accent, Color secondary) {
    return Container(
      color: config.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 34,
              height: 34,
              child: CircularProgressIndicator(strokeWidth: 2, color: secondary),
            ),
            const SizedBox(height: 12),
            Text(
              'WATCHDOG: RECONECTANDO STREAM (#$_reconnectAttempts)...',
              style: AppTheme.mono(fontSize: 11.5, fontWeight: FontWeight.bold, color: secondary),
            ),
            const SizedBox(height: 4),
            Text(
              'Detectada desconexión en ${widget.camera.ip}:${widget.camera.port}. Restableciendo pipeline...',
              textAlign: TextAlign.center,
              style: AppTheme.mono(fontSize: 9.5, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: secondary.withValues(alpha: 0.7)),
                minimumSize: const Size(130, 34),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ),
              onPressed: () {
                _reconnectAttempts = 0;
                _initializePlayer();
              },
              icon: Icon(Icons.refresh, size: 14, color: secondary),
              label: Text('FORZAR AHORA', style: AppTheme.mono(fontSize: 10, fontWeight: FontWeight.bold, color: secondary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBufferingHud(CyberdeckConfig config, Color accent, Color secondary) {
    return Container(
      color: config.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2, color: accent),
            ),
            const SizedBox(height: 12),
            Text(
              'CONECTANDO ENLACE RTSP // BUFFERING...',
              style: AppTheme.mono(fontSize: 11, fontWeight: FontWeight.bold, color: accent),
            ),
            const SizedBox(height: 4),
            Text(
              widget.camera.maskedUrl,
              style: AppTheme.mono(fontSize: 9.5, color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineHud(CyberdeckConfig config, Color accent, Color secondary) {
    return Container(
      color: config.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.signal_cellular_connected_no_internet_0_bar, size: 36, color: AppTheme.error),
            const SizedBox(height: 10),
            Text(
              'ENLACE RTSP INTERRUMPIDO // FEED OFFLINE',
              style: AppTheme.mono(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppTheme.error),
            ),
            const SizedBox(height: 4),
            Text(
              'IP/Host: ${widget.camera.ip}:${widget.camera.port} // Ruta: ${widget.camera.path}',
              style: AppTheme.mono(fontSize: 9.5, color: AppTheme.textSecondary),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'DIAG: $_errorMessage',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTheme.mono(fontSize: 8.5, color: AppTheme.amberAlert),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(120, 36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                  onPressed: () {
                    _reconnectAttempts = 0;
                    _initializePlayer();
                  },
                  icon: const Icon(Icons.refresh, size: 14, color: Colors.black),
                  label: Text('REINTENTAR', style: AppTheme.mono(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: accent.withValues(alpha: 0.6)),
                    minimumSize: const Size(120, 36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => CameraModalDialog(camera: widget.camera),
                    );
                  },
                  icon: Icon(Icons.tune, size: 14, color: accent),
                  label: Text('CONFIGURAR', style: AppTheme.mono(fontSize: 10, fontWeight: FontWeight.bold, color: accent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SurveillanceReticlePainter extends CustomPainter {
  final Color accentColor;

  const _SurveillanceReticlePainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accentColor.withValues(alpha: 0.25)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    const double radius = 22.0;

    // Center crosshairs
    canvas.drawCircle(center, radius, paint);
    canvas.drawLine(Offset(center.dx - radius - 8, center.dy), Offset(center.dx - 6, center.dy), paint);
    canvas.drawLine(Offset(center.dx + 6, center.dy), Offset(center.dx + radius + 8, center.dy), paint);
    canvas.drawLine(Offset(center.dx, center.dy - radius - 8), Offset(center.dx, center.dy - 6), paint);
    canvas.drawLine(Offset(center.dx, center.dy + 6), Offset(center.dx, center.dy + radius + 8), paint);
  }

  @override
  bool shouldRepaint(covariant _SurveillanceReticlePainter oldDelegate) {
    return oldDelegate.accentColor != accentColor;
  }
}
