import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math' as math;

import '../../../shared/providers/onboarding_provider.dart';

class CompleteStep extends ConsumerWidget {
  const CompleteStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final userData = onboardingState.data;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 완성된 별자리 애니메이션
            CustomAnimationBuilder<double>(
              control: Control.play,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.3 + (value * 0.7),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.amber.withOpacity(0.5),
                            Colors.amber.withOpacity(0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: CustomPaint(
                        painter: ConstellationCompletePainter(value),
                        size: const Size(200, 200),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // 축하 메시지
            CustomAnimationBuilder<Offset>(
              control: Control.play,
              tween: Tween<Offset>(
                begin: const Offset(0, 30),
                end: Offset.zero,
              ),
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Transform.translate(
                  offset: value,
                  child: Column(
                    children: [
                      Text(
                        '축하합니다!',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${userData.name ?? ''}님의 별자리가 완성되었습니다',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // 사용자 정보 요약
            CustomAnimationBuilder<double>(
              control: Control.play,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Opacity(
                  opacity: value,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '당신의 정보',
                          style: TextStyle(
                            color: Colors.amber.shade200,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('이름', userData.name ?? ''),
                        if (userData.birthDate != null)
                          _buildInfoRow(
                            '생년월일',
                            '${userData.birthDate!.year}년 ${userData.birthDate!.month}월 ${userData.birthDate!.day}일',
                          ),
                        if (userData.interests.isNotEmpty)
                          _buildInfoRow('관심사', '${userData.interests.length}개 선택'),
                        if (userData.concerns.isNotEmpty)
                          _buildInfoRow('고민', '${userData.concerns.length}개 선택'),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // 현자들 소개
            CustomAnimationBuilder<double>(
              control: Control.play,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Opacity(
                  opacity: value,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.purple.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.purple.shade300,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '7명의 현자들이 기다리고 있습니다',
                              style: TextStyle(
                                color: Colors.purple.shade200,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '이제 현자들과 대화하며 당신만의 지혜를 찾아보세요.\n'
                          '언제든 질문하고, 조언을 구하고, 새로운 관점을 얻을 수 있습니다.',
                          style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ConstellationCompletePainter extends CustomPainter {
  final double animationValue;

  ConstellationCompletePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    final starPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.amber.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = Colors.amber.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // 중앙 별
    canvas.drawCircle(center, 6 * animationValue, glowPaint);
    canvas.drawCircle(center, 4 * animationValue, starPaint);

    // 주변 6개 별과 연결선
    for (int i = 0; i < 6; i++) {
      final angle = (2 * 3.14159 * i / 6) - 3.14159 / 2;
      final starPos = Offset(
        center.dx + radius * animationValue * math.cos(angle),
        center.dy + radius * animationValue * math.sin(angle),
      );

      // 연결선
      if (animationValue > 0.5) {
        canvas.drawLine(center, starPos, linePaint);
      }

      // 별
      canvas.drawCircle(starPos, 3 * animationValue, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}