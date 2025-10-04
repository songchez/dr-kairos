import 'package:flutter/material.dart';
import 'dart:ui';

import '../../../shared/widgets/glassmorphic_container.dart';
import '../../../core/constants/app_constants.dart';

class CelestialWelcomeSection extends StatelessWidget {
  final AnimationController celestialController;

  const CelestialWelcomeSection({
    super.key,
    required this.celestialController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: AnimatedBuilder(
          animation: celestialController,
          builder: (context, child) {
            return GlassmorphicContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(20),
              gradientColors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
              borderColor: Colors.white.withOpacity(0.3),
              blurSigma: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.amber,
                        Colors.white,
                      ],
                      stops: [
                        0.0,
                        (celestialController.value * 2) % 1.0,
                        1.0,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      '영혼의 천구의에 오신 것을 환영합니다',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '7명의 현자들이 당신의 질문을 기다리고 있습니다\n우주의 지혜가 당신에게 흘러들어오길...',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}