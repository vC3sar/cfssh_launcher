import 'package:flutter/material.dart';

/// Minimum touch target recommended by Material / Android accessibility (48x48 dp).
const double kCyberMinTouchTarget = 48.0;

/// Reusable touch wrapper for every interactive Cyberdeck element.
/// Guarantees >= 48x48 dp touch area and smooth, responsive tactile visual feedback.
class CyberTapTarget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color pressColor;
  final BorderRadius borderRadius;
  final double minWidth;
  final double minHeight;
  final AlignmentGeometry alignment;
  final String? tooltip;
  final String? semanticLabel;
  final bool fillWidth;

  const CyberTapTarget({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.pressColor = const Color(0xFF0A84FF),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.minWidth = kCyberMinTouchTarget,
    this.minHeight = kCyberMinTouchTarget,
    this.alignment = Alignment.center,
    this.tooltip,
    this.semanticLabel,
    this.fillWidth = false,
  });

  @override
  State<CyberTapTarget> createState() => _CyberTapTargetState();
}

class _CyberTapTargetState extends State<CyberTapTarget> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (mounted && value != _pressed) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null || widget.onLongPress != null;

    final visual = AnimatedScale(
      scale: _pressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOutCubic,
      child: Container(
        width: widget.fillWidth ? double.infinity : null,
        foregroundDecoration: _pressed
            ? BoxDecoration(
                color: widget.pressColor.withValues(alpha: 0.14),
                borderRadius: widget.borderRadius,
              )
            : null,
        child: widget.child,
      ),
    );

    Widget result = Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onHighlightChanged: _setPressed,
        borderRadius: widget.borderRadius,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        hoverColor: widget.pressColor.withValues(alpha: 0.05),
        focusColor: widget.pressColor.withValues(alpha: 0.12),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.fillWidth ? double.infinity : widget.minWidth,
            minHeight: widget.minHeight,
          ),
          child: Align(
            alignment: widget.alignment,
            widthFactor: widget.fillWidth ? null : 1.0,
            heightFactor: 1.0,
            child: visual,
          ),
        ),
      ),
    );

    if (widget.semanticLabel != null) {
      result = Semantics(
        button: true,
        enabled: enabled,
        label: widget.semanticLabel,
        child: result,
      );
    }

    if (widget.tooltip != null && widget.onLongPress == null) {
      result = Tooltip(message: widget.tooltip!, child: result);
    }

    return result;
  }
}

/// Small icon action with a full 48x48 dp touch target.
class CyberIconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String tooltip;
  final double iconSize;

  const CyberIconAction({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.tooltip,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return CyberTapTarget(
      onTap: onTap,
      pressColor: color,
      tooltip: tooltip,
      semanticLabel: tooltip,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: iconSize, color: color),
      ),
    );
  }
}
