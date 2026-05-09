import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/app_assets.dart';
import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

class FeaturedWorkoutCard extends StatelessWidget {
  const FeaturedWorkoutCard({
    super.key,
    required this.metaLine,
    required this.title,
    this.onTap,
  });

  final String metaLine;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final light = Theme.of(context).brightness == Brightness.light;
    final lightFill =
        Color.alphaBlend(const Color(0x0E000000), p.background);

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(FitnessRadii.card),
      color: light ? lightFill : null,
      gradient: light
          ? null
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.card.withValues(alpha: 0.98),
                p.cardElevated,
              ],
            ),
      boxShadow: light
          ? null
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
    );

    final inner = DecoratedBox(
      decoration: decoration,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: p.featuredWorkoutAccentBar,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(metaLine, style: p.featuredWorkoutMeta),
                          const SizedBox(height: 2),
                          Text(title, style: p.featuredWorkoutTitle),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          p.textPrimary.withValues(alpha: 0.88),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          AppAssets.iconHomeArrowRight,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(FitnessRadii.card),
        splashColor: p.cyanAccent.withValues(alpha: 0.08),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(FitnessRadii.card),
          child: light
              ? inner
              : BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: inner,
                ),
        ),
      ),
    );
  }
}
