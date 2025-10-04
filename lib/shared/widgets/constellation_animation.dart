import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math' as math;

class ConstellationAnimation extends StatefulWidget {
  final List<ConstellationStar> stars;
  final List<ConstellationLine> lines;
  final Duration animationDuration;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const ConstellationAnimation({
    super.key,
    required this.stars,
    this.lines = const [],
    this.animationDuration = const Duration(seconds: 3),
    this.autoPlay = true,
    this.onComplete,
  });

  @override
  State<ConstellationAnimation> createState() => _ConstellationAnimationState();
}

class _ConstellationAnimationState extends State<ConstellationAnimation> {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    if (widget.autoPlay) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConstellationPainter(
        stars: widget.stars,
        lines: widget.lines,
        animationDuration: widget.animationDuration,
        autoPlay: widget.autoPlay,
        onComplete: widget.onComplete,
      ),
      size: Size.infinite,
    );
  }
}

class ConstellationPainter extends CustomPainter {
  final List<ConstellationStar> stars;
  final List<ConstellationLine> lines;
  final Duration animationDuration;
  final bool autoPlay;
  final VoidCallback? onComplete;

  ConstellationPainter({
    required this.stars,
    required this.lines,
    required this.animationDuration,
    required this.autoPlay,
    this.onComplete,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final starPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // 별들 그리기
    for (final star in stars) {
      final position = Offset(
        star.x * size.width,
        star.y * size.height,
      );

      // 글로우 효과
      canvas.drawCircle(position, star.size * 3, glowPaint);
      
      // 메인 별
      canvas.drawCircle(position, star.size, starPaint);
      
      // 반짝임 효과
      if (star.isTwinkling) {
        _drawTwinkle(canvas, position, star.size);
      }
    }

    // 연결선 그리기
    for (final line in lines) {
      final start = Offset(
        line.startX * size.width,
        line.startY * size.height,
      );
      final end = Offset(
        line.endX * size.width,
        line.endY * size.height,
      );

      canvas.drawLine(start, end, linePaint);
    }
  }

  void _drawTwinkle(Canvas canvas, Offset center, double size) {
    final twinklePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final sparkSize = size * 1.5;
    
    // 십자 모양 반짝임
    canvas.drawLine(
      Offset(center.dx - sparkSize, center.dy),
      Offset(center.dx + sparkSize, center.dy),
      twinklePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - sparkSize),
      Offset(center.dx, center.dy + sparkSize),
      twinklePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ConstellationStar {
  final double x; // 0.0 to 1.0 (relative position)
  final double y; // 0.0 to 1.0 (relative position)
  final double size;
  final bool isTwinkling;
  final Duration delay;

  const ConstellationStar({
    required this.x,
    required this.y,
    this.size = 2.0,
    this.isTwinkling = false,
    this.delay = Duration.zero,
  });
}

class ConstellationLine {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final Duration delay;

  const ConstellationLine({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    this.delay = Duration.zero,
  });
}

class AnimatedConstellation extends StatelessWidget {
  final int stepNumber;
  final bool isCompleted;
  final VoidCallback? onStarTapped;

  const AnimatedConstellation({
    super.key,
    required this.stepNumber,
    this.isCompleted = false,
    this.onStarTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.play,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + stepNumber * 200),
      builder: (context, value, child) {
        return CustomPaint(
          painter: AnimatedConstellationPainter(
            progress: value,
            stepNumber: stepNumber,
            isCompleted: isCompleted,
          ),
          size: const Size(60, 60),
          child: GestureDetector(
            onTap: onStarTapped,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedConstellationPainter extends CustomPainter {
  final double progress;
  final int stepNumber;
  final bool isCompleted;

  AnimatedConstellationPainter({
    required this.progress,
    required this.stepNumber,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // 메인 별 (중앙)
    final mainStarPaint = Paint()
      ..color = isCompleted ? Colors.amber : Colors.white
      ..style = PaintingStyle.fill;

    final mainStarSize = 4.0 * progress;
    
    // 글로우 효과
    if (progress > 0.5) {
      final glowPaint = Paint()
        ..color = (isCompleted ? Colors.amber : Colors.white).withOpacity(0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      
      canvas.drawCircle(center, mainStarSize * 2, glowPaint);
    }
    
    canvas.drawCircle(center, mainStarSize, mainStarPaint);

    // 주변 별들 (단계별로 추가)
    if (progress > 0.7) {
      _drawOrbitingStars(canvas, center, size, progress);
    }

    // 연결선 (완료시)
    if (isCompleted && progress > 0.8) {
      _drawConnectingLines(canvas, center, size);
    }

    // 반짝임 효과
    if (isCompleted) {
      _drawSparkles(canvas, center, mainStarSize);
    }
  }

  void _drawOrbitingStars(Canvas canvas, Offset center, Size size, double progress) {
    final orbitStarPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final orbitsProgress = (progress - 0.7) / 0.3;
    final orbitRadius = size.width * 0.3;
    final starCount = math.min(stepNumber + 1, 6);

    for (int i = 0; i < starCount; i++) {
      final angle = (2 * math.pi * i / starCount) - math.pi / 2;
      final starPosition = Offset(
        center.dx + math.cos(angle) * orbitRadius * orbitsProgress,
        center.dy + math.sin(angle) * orbitRadius * orbitsProgress,
      );

      canvas.drawCircle(starPosition, 2.0 * orbitsProgress, orbitStarPaint);
    }
  }

  void _drawConnectingLines(Canvas canvas, Offset center, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final orbitRadius = size.width * 0.3;
    final starCount = math.min(stepNumber + 1, 6);

    for (int i = 0; i < starCount; i++) {
      final angle = (2 * math.pi * i / starCount) - math.pi / 2;
      final starPosition = Offset(
        center.dx + math.cos(angle) * orbitRadius,
        center.dy + math.sin(angle) * orbitRadius,
      );

      canvas.drawLine(center, starPosition, linePaint);
    }
  }

  void _drawSparkles(Canvas canvas, Offset center, double starSize) {
    final sparklePaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final sparkleSize = starSize * 1.5;
    
    // 십자 모양 반짝임
    canvas.drawLine(
      Offset(center.dx - sparkleSize, center.dy),
      Offset(center.dx + sparkleSize, center.dy),
      sparklePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - sparkleSize),
      Offset(center.dx, center.dy + sparkleSize),
      sparklePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 온보딩 진행 상황을 시각적으로 표시하는 위젯
class ConstellationProgress extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final List<bool> completedSteps;

  const ConstellationProgress({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.completedSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedConstellation(
            stepNumber: index,
            isCompleted: index < completedSteps.length ? completedSteps[index] : false,
          ),
        );
      }),
    );
  }
}