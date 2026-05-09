import 'dart:math' show pi;

import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

import 'glass_stat_card.dart';

abstract final class _InsightTileTokens {
  static const EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 15);
  static const double captionSize = 11;

  static const double afterInsightHeadline = 4;
  static const double barHeight = 4;
  static const double afterProgressBar = 5;

  static TextStyle subtitle(FitnessPalette p) => TextStyle(
    color: p.textSecondary,
    fontSize: captionSize,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 1.18,
  );

  static TextStyle progressLabel(FitnessPalette p) => TextStyle(
    color: p.textTertiary,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.0,
  );
}

class _InsightMetricHeadline extends StatelessWidget {
  const _InsightMetricHeadline({
    required this.valueText,
    required this.unitLabel,
  });

  final String valueText;
  final String unitLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(valueText, style: p.insightMetricValue),
        const SizedBox(width: 2),
        Text(unitLabel, style: p.insightUnitLabel),
      ],
    );
  }
}

class CaloriesInsightCard extends StatelessWidget {
  const CaloriesInsightCard({
    super.key,
    required this.consumed,
    required this.remaining,
    required this.maxCalories,
  });

  final int consumed;
  final int remaining;
  final int maxCalories;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final progress = (consumed / maxCalories).clamp(0.0, 1.0);

    return SizedBox.expand(
      child: GlassStatCard(
        padding: _InsightTileTokens.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _InsightMetricHeadline(
                  valueText: '$consumed',
                  unitLabel: 'Calories',
                ),
                const SizedBox(height: _InsightTileTokens.afterInsightHeadline),
                Text(
                  '$remaining Remaining',
                  style: _InsightTileTokens.subtitle(p),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: _InsightTileTokens.barHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: p.insightProgressTrack,
                          borderRadius: BorderRadius.circular(
                            _InsightTileTokens.barHeight / 2,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: progress,
                        alignment: Alignment.centerLeft,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              _InsightTileTokens.barHeight / 2,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF3DEDED),
                                const Color(0xFF69C0B1),
                                const Color(0xFF60C198),
                              ],
                              stops: const [0.0, 0.45, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: p.cyanAccent.withValues(alpha: 0.28),
                                blurRadius: 6,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: _InsightTileTokens.afterProgressBar),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0', style: _InsightTileTokens.progressLabel(p)),
                    Text(
                      '$maxCalories',
                      style: _InsightTileTokens.progressLabel(p),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeightInsightCard extends StatelessWidget {
  const WeightInsightCard({
    super.key,
    required this.kg,
    required this.deltaLabel,
  });

  final int kg;
  final String deltaLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox.expand(
      child: GlassStatCard(
        padding: _InsightTileTokens.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _InsightMetricHeadline(valueText: '$kg', unitLabel: 'kg'),
                const SizedBox(height: _InsightTileTokens.afterInsightHeadline),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: p.trendGreen.withValues(alpha: 0.22),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 11.5,
                          color: p.neonGreen,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        deltaLabel,
                        style: _InsightTileTokens.subtitle(p),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Weight', style: p.insightFooterLabel),
          ],
        ),
      ),
    );
  }
}

abstract final class _HydrationTokens {
  static const double cardTopRadius = FitnessRadii.card;
  static const double bannerBottomRadius = 3;
}

class HydrationInsightCard extends StatelessWidget {
  const HydrationInsightCard({
    super.key,
    required this.percentText,
    required this.notificationText,
    this.litersCurrent = 0,
    this.litersGoal = 2,
  });

  final String percentText;
  final String notificationText;
  final double litersCurrent;
  final double litersGoal;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final brightness = Theme.of(context).brightness;
    final dark = brightness == Brightness.dark;
    final fill = litersGoal > 0
        ? (litersCurrent / litersGoal).clamp(0.0, 1.0)
        : 0.0;

    final axisStyle = TextStyle(
      color: p.textPrimary,
      fontSize: 10.5,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.05,
      height: 1.0,
    );
    final mlStyle = TextStyle(
      color: p.textPrimary,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.0,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_HydrationTokens.cardTopRadius),
          bottom: Radius.circular(_HydrationTokens.bannerBottomRadius),
        ),
        boxShadow: dark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_HydrationTokens.cardTopRadius),
          bottom: Radius.circular(_HydrationTokens.bannerBottomRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: dark
                    ? null
                    : Color.alphaBlend(
                        const Color(0x0E000000),
                        p.background,
                      ),
                gradient: dark
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          p.card.withValues(alpha: 0.95),
                          p.cardElevated.withValues(alpha: 0.9),
                        ],
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 12, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 124,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              percentText,
                              style: TextStyle(
                                color: p.hydrationBlue,
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1.05,
                                height: 1.02,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Hydration',
                                  style: TextStyle(
                                    color: p.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Log Now',
                                  style: TextStyle(
                                    color: p.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 124,
                      width: 132,
                      child: _HydrationScale(
                        fillFraction: fill,
                        maxLiters: litersGoal,
                        axisLabelStyle: axisStyle,
                        mlLabelStyle: mlStyle,
                        dashBright: dark
                            ? const Color(0xFF4FC3FF)
                            : const Color(0xFF078BFF),
                        dashMuted: dark
                            ? const Color(0xFF4A596B)
                            : const Color(0x1A607080),
                        axisLineColor: dark
                            ? const Color(0xFF5E6068)
                            : const Color(0x14607080),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: p.hydrationLogBanner,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    _HydrationTokens.bannerBottomRadius,
                  ),
                  bottomRight: Radius.circular(
                    _HydrationTokens.bannerBottomRadius,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 14,
                ),
                child: Text(
                  notificationText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: p.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HydrationScale extends StatelessWidget {
  const _HydrationScale({
    required this.fillFraction,
    required this.maxLiters,
    required this.axisLabelStyle,
    required this.mlLabelStyle,
    required this.dashBright,
    required this.dashMuted,
    required this.axisLineColor,
  });

  final double fillFraction;
  final double maxLiters;
  final TextStyle axisLabelStyle;
  final TextStyle mlLabelStyle;
  final Color dashBright;
  final Color dashMuted;
  final Color axisLineColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HydrationScalePainter(
        fillFraction: fillFraction,
        maxLiters: maxLiters,
        axisLabelStyle: axisLabelStyle,
        mlLabelStyle: mlLabelStyle,
        dashBright: dashBright,
        dashMuted: dashMuted,
        axisLineColor: axisLineColor,
      ),
    );
  }
}

class _HydrationScalePainter extends CustomPainter {
  _HydrationScalePainter({
    required this.fillFraction,
    required this.maxLiters,
    required this.axisLabelStyle,
    required this.mlLabelStyle,
    required this.dashBright,
    required this.dashMuted,
    required this.axisLineColor,
  });

  final double fillFraction;
  final double maxLiters;
  final TextStyle axisLabelStyle;
  final TextStyle mlLabelStyle;
  final Color dashBright;
  final Color dashMuted;
  final Color axisLineColor;

  static const int _dashCount = 11;
  static const double _dashW = 10;
  static const double _dashWMuted = 5;
  static const double _dashH = 3.4;
  static const double _gapAfterLabels = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final topL = '${maxLiters.toStringAsFixed(0)} L';
    const botL = '0 L';

    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(text: topL, style: axisLabelStyle);
    tp.layout();
    final wTop = tp.width;
    tp.text = TextSpan(text: botL, style: axisLabelStyle);
    tp.layout();
    final wBot = tp.width;
    final labelAlignRight = wTop > wBot ? wTop : wBot;
    final dashLeft = labelAlignRight + _gapAfterLabels;

    final marginBottom = 20.0;
    const plotTop = 10.0;
    final plotBottom = size.height - marginBottom;
    final span = plotBottom - plotTop;
    final step = span / (_dashCount - 1);

    final dashPaintBright = Paint()..color = dashBright;
    final dashPaintMuted = Paint()..color = dashMuted;

    if (fillFraction > 0.02) {
      final fillH = span * fillFraction;
      final fillTop = plotBottom - fillH;
      final fillR = RRect.fromLTRBR(
        dashLeft,
        fillTop,
        dashLeft + _dashW,
        plotBottom,
        Radius.circular(_dashH / 2),
      );
      canvas.drawRRect(
        fillR,
        Paint()
          ..color = dashBright.withValues(alpha: 0.22)
          ..style = PaintingStyle.fill,
      );
    }

    for (var i = 0; i < _dashCount; i++) {
      final cy = plotTop + i * step;
      final isBright = i == 0 || i == 5 || i == 10;
      final paint = isBright ? dashPaintBright : dashPaintMuted;
      final dw = isBright ? _dashW : _dashWMuted;
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(dashLeft + _dashW / 2, cy),
          width: dw,
          height: _dashH,
        ),
        Radius.circular(_dashH / 2),
      );
      canvas.drawRRect(rect, paint);
    }

    tp.text = TextSpan(text: topL, style: axisLabelStyle);
    tp.layout();
    tp.paint(canvas, Offset(labelAlignRight - wTop, plotTop - tp.height / 2));

    tp.text = TextSpan(text: botL, style: axisLabelStyle);
    tp.layout();
    tp.paint(
      canvas,
      Offset(labelAlignRight - wBot, plotBottom - tp.height / 2),
    );

    final yBottom = plotTop + 10 * step;
    tp.text = TextSpan(text: '0ml', style: mlLabelStyle);
    tp.layout();
    final xMl = size.width - tp.width;
    final xLineStart = dashLeft + _dashW + 3;
    final xLineEnd = (xMl - 5).clamp(xLineStart, size.width);

    final linePaint = Paint()
      ..color = axisLineColor
      ..strokeWidth = 0.85
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(xLineStart, yBottom),
      Offset(xLineEnd, yBottom),
      linePaint,
    );

    tp.paint(canvas, Offset(xMl, yBottom - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _HydrationScalePainter oldDelegate) {
    return oldDelegate.fillFraction != fillFraction ||
        oldDelegate.maxLiters != maxLiters ||
        oldDelegate.axisLabelStyle != axisLabelStyle ||
        oldDelegate.mlLabelStyle != mlLabelStyle ||
        oldDelegate.dashBright != dashBright ||
        oldDelegate.dashMuted != dashMuted ||
        oldDelegate.axisLineColor != axisLineColor;
  }
}
