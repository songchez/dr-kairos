import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'cosmic_background.dart';

class EnhancedCosmicBackground extends StatelessWidget {
  final AnimationController parallaxController;
  final AnimationController celestialController;
  final double parallaxOffset;

  const EnhancedCosmicBackground({
    super.key,
    required this.parallaxController,
    required this.celestialController,
    this.parallaxOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: parallaxController,
      builder: (context, child) {
        return Stack(
          children: [
            // 기본 우주 배경
            CosmicBackground(
              child: Container(),
            ),
            
            // 먼 별층 (느린 시차)
            AnimatedBuilder(
              animation: celestialController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    (parallaxController.value * 100 + parallaxOffset * 50) % MediaQuery.of(context).size.width,
                    math.sin(celestialController.value * 2 * math.pi) * 20
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CustomPaint(
                      painter: StarFieldPainter(
                        animation: celestialController.value,
                        density: 50,
                        brightness: 0.3,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            // 가까운 성운층 (빠른 시차)
            AnimatedBuilder(
              animation: parallaxController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    (parallaxController.value * 200 + parallaxOffset * 100) % (MediaQuery.of(context).size.width * 1.5),
                    0
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.5,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0.3, -0.4),
                        radius: 1.2,
                        colors: [
                          Colors.purple.withOpacity(0.1),
                          Colors.blue.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class ParticleOverlayWidget extends StatelessWidget {
  final AnimationController pulseController;
  final int particleCount;

  const ParticleOverlayWidget({
    super.key,
    required this.pulseController,
    this.particleCount = 30,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        return IgnorePointer(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: ParticleOverlayPainter(
                animation: pulseController.value,
                particleCount: particleCount,
              ),
            ),
          ),
        );
      },
    );
  }
}

// CustomPaint 클래스들
class StarFieldPainter extends CustomPainter {
  final double animation;
  final int density;
  final double brightness;

  StarFieldPainter({
    required this.animation,
    required this.density,
    required this.brightness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(brightness)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // 고정 시드로 일관된 별 위치
    
    for (int i = 0; i < density; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 0.5;
      
      // 별의 깜빡임 효과
      final twinkle = math.sin((animation * 2 * math.pi) + (i * 0.1)) * 0.3 + 0.7;
      paint.color = Colors.white.withOpacity(brightness * twinkle);
      
      canvas.drawCircle(Offset(x, y), radius, paint);
      
      // 더 밝은 별들에 십자 효과
      if (radius > 1.5) {
        final linePaint = Paint()
          ..color = Colors.white.withOpacity(brightness * twinkle * 0.5)
          ..strokeWidth = 0.5;
        
        canvas.drawLine(
          Offset(x - radius * 2, y),
          Offset(x + radius * 2, y),
          linePaint,
        );
        canvas.drawLine(
          Offset(x, y - radius * 2),
          Offset(x, y + radius * 2),
          linePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class ParticleOverlayPainter extends CustomPainter {
  final double animation;
  final int particleCount;

  ParticleOverlayPainter({
    required this.animation,
    required this.particleCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final random = math.Random(123);
    
    for (int i = 0; i < particleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final phase = (animation + i * 0.1) % 1.0;
      
      // 입자 크기와 투명도
      final opacity = math.sin(phase * math.pi) * 0.3;
      final radius = (math.sin(phase * math.pi) * 2 + 1) * 0.5;
      
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticleOverlayPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}