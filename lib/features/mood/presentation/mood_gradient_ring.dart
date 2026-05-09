import 'dart:math' as math;

import 'package:flutter/material.dart';

abstract final class MoodRingSpectrum {
  static const Color orange = Color(0xFFF7A06D);

  static const Color teal = Color(0xFF87D1C1);

  static const Color lavender = Color(0xFFC7B4E5);

  static const Color pink = Color(0xFFF094B4);
}

const List<double> _kMoodSweepStopsFive = [0.0, 0.25, 0.5, 0.75, 1.0];

List<Color> _moodRingSweepColors() {
  const o = MoodRingSpectrum.orange;
  const t = MoodRingSpectrum.teal;
  const l = MoodRingSpectrum.lavender;
  const p = MoodRingSpectrum.pink;
  return <Color>[t, l, p, o, t];
}

const List<String> kQuadrantMoodLabels = [
  'Calm',
  'Content',
  'Peaceful',
  'Happy',
];

double moodSweepFromPan(Offset center, Offset local) {
  final dx = local.dx - center.dx;
  final dy = local.dy - center.dy;
  var s = math.atan2(dy, dx) + math.pi / 2;
  s %= 2 * math.pi;
  if (s < 0) {
    s += 2 * math.pi;
  }
  return s;
}

int moodIndexFromSweep(double sweep) {
  const seg = math.pi / 2;
  return (sweep / seg).floor() % 4;
}

class MoodGradientRing extends StatefulWidget {
  const MoodGradientRing({
    super.key,
    required this.size,
    this.initialSweep,
    required this.onMoodChanged,
  });

  final double size;

  final double? initialSweep;
  final ValueChanged<String> onMoodChanged;

  @override
  State<MoodGradientRing> createState() => _MoodGradientRingState();
}

class _MoodGradientRingState extends State<MoodGradientRing> {
  late double _sweep;

  static const double _outer = 1;
  static const double _inner = 0.82;

  @override
  void initState() {
    super.initState();
    _sweep = widget.initialSweep ?? (math.pi / 4);
  }

  void _handlePan(Offset local) {
    final c = Offset(widget.size / 2, widget.size / 2);
    final dx = local.dx - c.dx;
    final dy = local.dy - c.dy;
    final dist = math.sqrt(dx * dx + dy * dy);
    if (dist < 16) {
      return;
    }
    final sweep = moodSweepFromPan(c, local);
    setState(() => _sweep = sweep);
    widget.onMoodChanged(kQuadrantMoodLabels[moodIndexFromSweep(sweep)]);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.size / 2;
    final trackR = c * (_outer + _inner) / 2;
    final knobX = c + trackR * math.sin(_sweep);
    final knobY = c - trackR * math.cos(_sweep);
    const knobD = 38.0;
    final knobR = knobD / 2;

    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (e) => _handlePan(e.localPosition),
      onPointerMove: (e) => _handlePan(e.localPosition),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _RingPainter(
                outerFraction: _outer,
                innerFraction: _inner,
              ),
            ),
            Positioned(
              left: knobX - knobR,
              top: knobY - knobR,
              child: IgnorePointer(
                child: Container(
                  width: knobD,
                  height: knobD,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5),
                        blurRadius: 18,
                        spreadRadius: 1.5,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.32),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
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

class _RingPainter extends CustomPainter {
  _RingPainter({required this.outerFraction, required this.innerFraction});

  final double outerFraction;
  final double innerFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2;
    final outerR = r * outerFraction;
    final innerR = r * innerFraction;
    final midR = (outerR + innerR) / 2;
    final strokeW = outerR - innerR;

    final rect = Rect.fromCircle(center: c, radius: outerR);
    final sweepColors = _moodRingSweepColors();
    final shader = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: math.pi * 3 / 2,
      colors: sweepColors,
      stops: _kMoodSweepStopsFive,
    ).createShader(rect);

    final ringPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: c, radius: midR),
      -math.pi / 2,
      2 * math.pi,
      false,
      ringPaint,
    );

    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 4; i++) {
      final ang = -math.pi / 2 + i * math.pi / 2;
      final cs = math.cos(ang);
      final sn = math.sin(ang);
      canvas.drawLine(
        Offset(c.dx + innerR * cs * 0.98, c.dy + innerR * sn * 0.98),
        Offset(c.dx + outerR * cs * 1.02, c.dy + outerR * sn * 1.02),
        tickPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.outerFraction != outerFraction ||
        oldDelegate.innerFraction != innerFraction;
  }
}
