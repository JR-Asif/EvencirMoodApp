import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

class GlassStatCard extends StatelessWidget {
  const GlassStatCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = FitnessRadii.card,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final light = Theme.of(context).brightness == Brightness.light;

    final lightFill =
        Color.alphaBlend(const Color(0x0E000000), p.background);

    final deco = BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: light ? lightFill : null,
      gradient: light
          ? null
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.card.withValues(alpha: 0.92),
                p.cardElevated.withValues(alpha: 0.88),
                p.card,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
      boxShadow: light
          ? null
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: p.cyanAccent.withValues(alpha: 0.03),
                blurRadius: 20,
                spreadRadius: -4,
              ),
            ],
    );

    final card = DecoratedBox(
      decoration: deco,
      child: Padding(padding: padding, child: child),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: light ? card : BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: card,
          ),
    );
  }
}
