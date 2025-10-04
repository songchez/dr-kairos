import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

import '../../../shared/widgets/glassmorphic_container.dart';
import '../../../core/constants/app_constants.dart';

class GlassmorphicQuickActions extends StatelessWidget {
  final AnimationController pulseController;
  final VoidCallback onRoundtableToggle;
  final VoidCallback onRecommendedConsultation;

  const GlassmorphicQuickActions({
    super.key,
    required this.pulseController,
    required this.onRoundtableToggle,
    required this.onRecommendedConsultation,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        child: AnimatedBuilder(
          animation: pulseController,
          builder: (context, child) {
            return Row(
              children: [
                Expanded(
                  child: _buildEnhancedQuickActionCard(
                    icon: Icons.forum_outlined,
                    title: '현자들의 원탁',
                    subtitle: '7명의 조언을 한번에',
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.3),
                        Colors.blue.withOpacity(0.2),
                      ],
                    ),
                    onTap: onRoundtableToggle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildEnhancedQuickActionCard(
                    icon: Icons.psychology_outlined,
                    title: '즉시 상담',
                    subtitle: '추천 현자와 대화',
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.withOpacity(0.3),
                        Colors.orange.withOpacity(0.2),
                      ],
                    ),
                    onTap: onRecommendedConsultation,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEnhancedQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        return GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: Stack(
                  children: [
                    // 배경 그라데이션
                    Container(
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    
                    // 컨텐츠
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              icon, 
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // 맥동 효과
                    if (pulseController.value > 0.7)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}