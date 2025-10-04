import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class CosmicBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? gradientColors;
  final bool enableParallax;
  final double parallaxStrength;

  const CosmicBackground({
    super.key,
    required this.child,
    this.gradientColors,
    this.enableParallax = true,
    this.parallaxStrength = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [
      const Color(0xFF0F0B1A),
      const Color(0xFF2D1B69),
      const Color(0xFF6C5CE7),
    ];

    return Stack(
      children: [
        // 기본 그라데이션 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        ),
        
        // 움직이는 별들
        if (enableParallax) ...[
          _buildStarLayer(offset: 0.0, starCount: 50, opacity: 0.3),
          _buildStarLayer(offset: 0.5, starCount: 30, opacity: 0.5),
          _buildStarLayer(offset: 1.0, starCount: 20, opacity: 0.8),
        ],
        
        // 자식 위젯
        child,
      ],
    );
  }

  Widget _buildStarLayer({
    required double offset,
    required int starCount,
    required double opacity,
  }) {
    return CustomAnimationBuilder<double>(
      control: Control.loop,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(seconds: (20 + offset * 10).round()),
      builder: (context, value, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: StarsPainter(
            animationValue: value,
            starCount: starCount,
            opacity: opacity,
            parallaxOffset: offset * parallaxStrength,
          ),
        );
      },
    );
  }
}

class StarsPainter extends CustomPainter {
  final double animationValue;
  final int starCount;
  final double opacity;
  final double parallaxOffset;

  StarsPainter({
    required this.animationValue,
    required this.starCount,
    required this.opacity,
    required this.parallaxOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < starCount; i++) {
      final normalizedIndex = i / starCount;
      
      // 의사 랜덤 위치 계산
      final x = (size.width * ((normalizedIndex * 7) % 1) + 
                animationValue * parallaxOffset * size.width) % size.width;
      final y = (size.height * ((normalizedIndex * 13) % 1) + 
                animationValue * parallaxOffset * size.height) % size.height;
      
      // 별의 크기 (1-3px)
      final starSize = 1.0 + (normalizedIndex * 2);
      
      // 반짝임 효과
      final twinkle = (1.0 + (normalizedIndex * 17) % 1) * 2 - 1;
      final twinkleValue = (animationValue * 4 + twinkle) % 2;
      final brightness = twinkleValue > 1 ? 2 - twinkleValue : twinkleValue;
      
      paint.color = Colors.white.withOpacity(opacity * brightness);
      
      canvas.drawCircle(
        Offset(x, y),
        starSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParallaxLayer extends StatelessWidget {
  final Widget child;
  final double parallaxStrength;
  final Duration duration;

  const ParallaxLayer({
    super.key,
    required this.child,
    this.parallaxStrength = 0.1,
    this.duration = const Duration(seconds: 20),
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<Offset>(
      control: Control.loop,
      tween: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(parallaxStrength, parallaxStrength * 0.5),
      ),
      duration: duration,
      builder: (context, value, _) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
    );
  }
}