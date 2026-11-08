import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';

class PingScreen extends ConsumerStatefulWidget {
  const PingScreen({super.key});

  @override
  ConsumerState<PingScreen> createState() => _PingScreenState();
}

class _PingScreenState extends ConsumerState<PingScreen> {
  final TextEditingController _ipController = TextEditingController(text: '1.1.1.1');
  String _output = '';
  bool _isPinging = false;

  Future<void> _runPing() async {
    final ip = _ipController.text.trim();
    if (ip.isEmpty) return;

    setState(() {
      _isPinging = true;
      _output = 'Ejecutando ping hacia $ip...\n\n';
    });

    try {
      final result = await Process.run('/system/bin/ping', ['-c', '4', ip]);
      setState(() {
        _output += result.stdout.toString();
        if (result.stderr.toString().isNotEmpty) {
          _output += '\nError:\n${result.stderr}';
        }
      });
    } catch (e) {
      setState(() {
        _output += 'Error al ejecutar ping: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isPinging = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    return Scaffold(
      backgroundColor: config.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Diagnóstico Ping ICMP',
          style: AppTheme.mono(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: config.textPrimaryColor,
          ),
        ),
        backgroundColor: config.panelColor,
        elevation: 0,
        iconTheme: IconThemeData(color: config.textPrimaryColor),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: config.borderColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: config.panelColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: config.borderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ipController,
                        style: AppTheme.mono(
                          fontSize: 14,
                          color: config.textPrimaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Dirección IP o Dominio (ej. 1.1.1.1)',
                          hintStyle: AppTheme.mono(
                            fontSize: 13,
                            color: config.textSecondaryColor,
                          ),
                          filled: true,
                          fillColor: config.surfaceSecondaryColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: config.borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: config.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accent, width: 1.5),
                          ),
                        ),
                        keyboardType: TextInputType.url,
                        onSubmitted: (_) => _runPing(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isPinging ? null : _runPing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isPinging
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Ejecutar',
                              style: AppTheme.mono(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: config.panelColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: config.borderColor),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _output.isEmpty
                          ? 'Introduce un host o dirección IP y pulsa "Ejecutar".'
                          : _output,
                      style: AppTheme.codeMono(
                        color: _output.isEmpty
                            ? config.textSecondaryColor
                            : config.textPrimaryColor,
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
