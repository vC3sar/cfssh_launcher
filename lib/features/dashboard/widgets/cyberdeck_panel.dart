import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CyberdeckPanel extends StatelessWidget {
  final String moduleCode;
  final String title;
  final Widget child;
  final Color accentColor;
  final Color? panelColor;
  final Color? statusColor;
  final String? statusLabel;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final bool showVisualEffects;

  const CyberdeckPanel({
    super.key,
    required this.moduleCode,
    required this.title,
    required this.child,
    required this.accentColor,
    this.panelColor,
    this.statusColor,
    this.statusLabel,
    this.actions,
    this.padding = const EdgeInsets.all(14),
    this.showVisualEffects = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStatusColor = statusColor ?? accentColor;
    final effectivePanelColor = panelColor ?? AppTheme.cardBackground;
    final borderColor = AppTheme.cardBorder;

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: effectivePanelColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Clean Minimalist Module Header Bar (48dp touch height)
            Container(
              constraints: const BoxConstraints(minHeight: 46),
              padding: const EdgeInsets.only(left: 14, right: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Discrete status dot (no neon glow)
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: effectiveStatusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Subtle Cyberdeck module code pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceSecondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      moduleCode,
                      style: AppTheme.codeMono(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTheme.mono(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (statusLabel != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: effectiveStatusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusLabel!,
                        style: AppTheme.mono(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: effectiveStatusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  ...?actions,
                ],
              ),
            ),
            Padding(
              padding: padding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class CyberdeckSegmentedBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color activeColor;
  final int segments;
  final double height;

  const CyberdeckSegmentedBar({
    super.key,
    required this.value,
    required this.activeColor,
    this.segments = 16,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: LinearProgressIndicator(
          value: clamped,
          backgroundColor: AppTheme.surfaceSecondary,
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
        ),
      ),
    );
  }
}
