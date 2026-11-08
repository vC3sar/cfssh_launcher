import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/cyberdeck_config_provider.dart';
import '../../core/theme/app_theme.dart';
import 'shortcut_model.dart';
import 'shortcuts_provider.dart';

class ShortcutDialog extends ConsumerStatefulWidget {
  final ShortcutModel? shortcut;
  const ShortcutDialog({super.key, this.shortcut});

  @override
  ConsumerState<ShortcutDialog> createState() => _ShortcutDialogState();
}

class _ShortcutDialogState extends ConsumerState<ShortcutDialog> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  String _type = 'url';
  String _selectedPreset = 'Ninguna (Personalizado)';

  final List<Map<String, String>> _presets = [
    {'title': 'Ninguna (Personalizado)', 'type': 'url', 'value': ''},
    {'title': 'Ping a Google', 'type': 'cmd', 'value': 'ping -c 4 google.com'},
    {'title': 'Proxmox Web UI', 'type': 'url', 'value': 'https://192.168.1.100:8006'},
    {'title': 'Portainer', 'type': 'url', 'value': 'https://192.168.1.100:9443'},
    {'title': 'SSH a Router Local', 'type': 'ssh', 'value': 'root@192.168.1.1'},
    {'title': 'Htop Local', 'type': 'cmd', 'value': 'htop'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.shortcut != null) {
      _titleController.text = widget.shortcut!.title;
      _valueController.text = widget.shortcut!.value;
      _type = widget.shortcut!.type;
    }
  }

  void _applyPreset(String presetTitle) {
    setState(() => _selectedPreset = presetTitle);
    if (presetTitle == 'Ninguna (Personalizado)') {
      if (widget.shortcut == null) {
        _titleController.clear();
        _valueController.clear();
        setState(() => _type = 'url');
      }
      return;
    }

    final preset = _presets.firstWhere((p) => p['title'] == presetTitle);
    _titleController.text = preset['title']!;
    _valueController.text = preset['value']!;
    setState(() => _type = preset['type']!);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_titleController.text.trim().isEmpty ||
        _valueController.text.trim().isEmpty) {
      return;
    }

    final newShortcut = ShortcutModel(
      id: widget.shortcut?.id,
      title: _titleController.text.trim(),
      type: _type,
      value: _valueController.text.trim(),
    );

    final dbService = ref.read(databaseServiceProvider);
    await dbService.insertShortcut(newShortcut);
    ref.invalidate(shortcutsProvider);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(cyberdeckConfigProvider);
    final accent = config.primaryAccent;

    return Dialog(
      backgroundColor: config.panelColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: config.borderColor),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.shortcut == null
                    ? 'Nuevo Acceso Directo'
                    : 'Editar Acceso Directo',
                style: AppTheme.mono(
                  color: config.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.shortcut == null) ...[
                DropdownButtonFormField<String>(
                  initialValue: _selectedPreset,
                  dropdownColor: config.panelColor,
                  decoration: InputDecoration(
                    labelText: 'Plantilla rápida',
                    labelStyle: AppTheme.mono(
                      fontSize: 12,
                      color: config.textSecondaryColor,
                    ),
                    filled: true,
                    fillColor: config.surfaceSecondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: config.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: config.borderColor),
                    ),
                  ),
                  items: _presets
                      .map(
                        (p) => DropdownMenuItem(
                          value: p['title'],
                          child: Text(
                            p['title']!,
                            style: AppTheme.mono(
                              fontSize: 13,
                              color: config.textPrimaryColor,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) _applyPreset(val);
                  },
                ),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: AppTheme.mono(
                    fontSize: 12,
                    color: config.textSecondaryColor,
                  ),
                  filled: true,
                  fillColor: config.surfaceSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                ),
                style: AppTheme.mono(
                  fontSize: 13,
                  color: config.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _type,
                dropdownColor: config.panelColor,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: AppTheme.mono(
                    fontSize: 12,
                    color: config.textSecondaryColor,
                  ),
                  filled: true,
                  fillColor: config.surfaceSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'url',
                    child: Text(
                      'Sitio Web (URL)',
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ssh',
                    child: Text(
                      'Conexión SSH',
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'cmd',
                    child: Text(
                      'Comando Local',
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: config.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _type = val);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Destino (URL, usuario@ip o comando)',
                  labelStyle: AppTheme.mono(
                    fontSize: 12,
                    color: config.textSecondaryColor,
                  ),
                  filled: true,
                  fillColor: config.surfaceSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: config.borderColor),
                  ),
                ),
                style: AppTheme.codeMono(
                  fontSize: 12.5,
                  color: config.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: config.textSecondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Guardar',
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
