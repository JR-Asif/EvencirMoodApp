import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:evencir_mood_app/core/theme/app_assets.dart';
import 'package:evencir_mood_app/core/theme/fitness_theme.dart';
import 'package:evencir_mood_app/features/mood/presentation/mood_gradient_ring.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String _moodLabel = 'Calm';

  static const _hPad = 20.0;

  static const _ringSize = 232.0;
  static const _avatarSize = 88.0;

  static const _continueHeight = 46.0;
  static const _continueRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    final p = context.palette;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.fitnessSystemUi,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: p.background),
            const _MoodTopRadialGlow(),
            SafeArea(
              top: true,
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: _hPad,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Mood',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: p.textPrimary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.0,
                                  height: 1.02,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start your day',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: p.textPrimary.withValues(
                                          alpha: 0.72,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.12,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'How are you feeling at the\nMoment?',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: p.textPrimary,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.45,
                                        height: 1.22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: math.max(20, c.maxHeight * 0.04),
                              ),
                              Center(
                                child: SizedBox(
                                  width: _ringSize,
                                  height: _ringSize,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      MoodGradientRing(
                                        size: _ringSize,
                                        initialSweep: math.pi / 4,
                                        onMoodChanged: (m) {
                                          setState(() => _moodLabel = m);
                                        },
                                      ),
                                      IgnorePointer(
                                        child: _MoodPictureAvatar(
                                          moodLabel: _moodLabel,
                                          size: _avatarSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: Text(
                                  _moodLabel,
                                  style: TextStyle(
                                    color: p.textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      _hPad,
                      8,
                      _hPad,
                      math.max(12.0, bottomSafe > 0 ? 8.0 : 16.0),
                    ),
                    child: SizedBox(
                      height: _continueHeight,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(
                            double.infinity,
                            _continueHeight,
                          ),
                          maximumSize: const Size(
                            double.infinity,
                            _continueHeight,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              _continueRadius,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodTopRadialGlow extends StatelessWidget {
  const _MoodTopRadialGlow();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    final wash =
        Color.lerp(p.moodGlowCore, const Color.fromARGB(255, 30, 84, 134), 0.38)!;
    final core = Color.lerp(wash, const Color.fromARGB(255, 108, 148, 181), 0.30)!;
    final lift = h * 0.018;

    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Transform.translate(
          offset: Offset(0, -lift),
          child: SizedBox(
            width: w ,
            height: h * 0.54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0, -0.82),
                  radius:1.16,
                  colors: [
                    core.withValues(alpha: 0.58),
                    wash.withValues(alpha: 0.34),
                    wash.withValues(alpha: 0.16),
                    Color.lerp(wash, p.background, 0.72)!
                        .withValues(alpha: 0.07),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.2, 0.45, 0.78, 1.0],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodPictureAvatar extends StatelessWidget {
  const _MoodPictureAvatar({required this.moodLabel, required this.size});

  final String moodLabel;
  final double size;

  static const Duration _kAnim = Duration(milliseconds: 1200);

  static const Map<String, String> _assetByMood = <String, String>{
    'Calm': AppAssets.moodCalm,
    'Content': AppAssets.moodContent,
    'Peaceful': AppAssets.moodPeaceful,
    'Happy': AppAssets.moodHappy,
  };

  @override
  Widget build(BuildContext context) {
    final path = _assetByMood[moodLabel] ?? AppAssets.moodCalm;
    final radius = size * 0.28;

    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: AnimatedSwitcher(
          duration: _kAnim,
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              fit: StackFit.expand,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Image.asset(
            path,
            key: ValueKey<String>(path),
            width: size,
            height: size,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}
