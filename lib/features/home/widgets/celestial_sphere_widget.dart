import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'dart:math' as math;

import '../../../shared/models/sage_model.dart';

class CelestialSphereWidget extends ConsumerWidget {
  final List<SageModel> sages;
  final AnimationController celestialController;
  final AnimationController pulseController;
  final bool showRoundtable;
  final VoidCallback onRoundtableToggle;
  final Function(SageModel) onSageTap;

  const CelestialSphereWidget({
    super.key,
    required this.sages,
    required this.celestialController,
    required this.pulseController,
    required this.showRoundtable,
    required this.onRoundtableToggle,
    required this.onSageTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 400,
      child: AnimatedBuilder(
        animation: celestialController,
        builder: (context, child) {
          final screenWidth = MediaQuery.of(context).size.width;
          final centerX = screenWidth / 2;
          final centerY = 200.0;
          final radius = math.min(screenWidth * 0.25, 120.0);
          
          return Stack(
            children: [
              // 천구의 연결선 (배경)
              CustomPaint(
                size: Size(screenWidth, 400),
                painter: CelestialSpherePainter(
                  sageCount: sages.length,
                  centerX: centerX,
                  centerY: centerY,
                  radius: radius,
                  animation: celestialController.value,
                ),
              ),
              
              // 중앙의 원탁 버튼
              Positioned(
                left: centerX - 60,
                top: centerY - 60,
                child: AnimatedBuilder(
                  animation: pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + pulseController.value * 0.1,
                      child: GestureDetector(
                        onTap: onRoundtableToggle,
                        child: Container(
                          width: 120,
                          height: 120,
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.3),
                                      Colors.white.withOpacity(0.1),
                                      Colors.transparent,
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.6 + pulseController.value * 0.4),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.forum,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '원탁',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // 현자들
              ...List.generate(sages.length, (index) {
                final sage = sages[index];
                final angle = (index * 2 * math.pi / sages.length) + 
                            (celestialController.value * 2 * math.pi * 0.05);
                
                final x = centerX + radius * math.cos(angle);
                final y = centerY + radius * math.sin(angle);
                
                return Positioned(
                  left: x - 40,
                  top: y - 50,
                  child: AnimatedBuilder(
                    animation: pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + math.sin(pulseController.value * 2 * math.pi + index * 0.5) * 0.1,
                        child: GestureDetector(
                          onTap: () => onSageTap(sage),
                          child: Container(
                            width: 80,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.25),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.4 + pulseController.value * 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // 현자 아바타
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(
                                            colors: [
                                              Colors.white.withOpacity(0.4),
                                              Colors.transparent,
                                            ],
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.6),
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'public/${sage.name.toLowerCase()}_avatar.png',
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: _getSageColor(sage.name).withOpacity(0.4),
                                                child: Icon(
                                                  _getSageIcon(sage.name),
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 6),
                                      
                                      // 현자 이름
                                      Text(
                                        sage.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // 현자별 색상 반환
  Color _getSageColor(String sageName) {
    switch (sageName) {
      case 'Stella':
        return Colors.purple;
      case 'Solon':
        return Colors.green;
      case 'Orion':
        return Colors.blue;
      case 'Dr. Kairos':
        return Colors.orange;
      case 'Gaia':
        return Colors.brown;
      case 'Logos':
        return Colors.cyan;
      case 'Morpheus':
        return Colors.indigo;
      default:
        return Colors.white;
    }
  }

  // 현자별 아이콘 반환
  IconData _getSageIcon(String sageName) {
    switch (sageName) {
      case 'Stella':
        return Icons.star;
      case 'Solon':
        return Icons.balance;
      case 'Orion':
        return Icons.auto_awesome;
      case 'Dr. Kairos':
        return Icons.psychology;
      case 'Gaia':
        return Icons.nature;
      case 'Logos':
        return Icons.analytics;
      case 'Morpheus':
        return Icons.bedtime;
      default:
        return Icons.person;
    }
  }
}

class CelestialSpherePainter extends CustomPainter {
  final int sageCount;
  final double centerX;
  final double centerY;
  final double radius;
  final double animation;

  CelestialSpherePainter({
    required this.sageCount,
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 원형 경계선
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    canvas.drawCircle(Offset(centerX, centerY), radius, circlePaint);
    
    // 현자들 간의 연결선 (별자리 효과)
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    for (int i = 0; i < sageCount; i++) {
      final angle1 = (i * 2 * math.pi / sageCount) + (animation * 2 * math.pi * 0.05);
      final angle2 = ((i + 1) % sageCount * 2 * math.pi / sageCount) + (animation * 2 * math.pi * 0.05);
      
      final x1 = centerX + radius * math.cos(angle1);
      final y1 = centerY + radius * math.sin(angle1);
      final x2 = centerX + radius * math.cos(angle2);
      final y2 = centerY + radius * math.sin(angle2);
      
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      
      // 중심에서 각 현자로의 연결선
      final centerLinePaint = Paint()
        ..color = Colors.white.withOpacity(0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.3;
      
      canvas.drawLine(Offset(centerX, centerY), Offset(x1, y1), centerLinePaint);
    }
    
    // 중앙에 맥동하는 원
    final centralPulsePaint = Paint()
      ..color = Colors.white.withOpacity(0.1 + math.sin(animation * 2 * math.pi * 2) * 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawCircle(Offset(centerX, centerY), 60 + math.sin(animation * 2 * math.pi * 2) * 5, centralPulsePaint);
  }

  @override
  bool shouldRepaint(covariant CelestialSpherePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}