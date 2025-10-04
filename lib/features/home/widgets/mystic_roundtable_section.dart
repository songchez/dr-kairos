import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/glassmorphic_container.dart';
import '../../../shared/widgets/carousel_3d.dart';
import '../../../shared/widgets/sage_profile_card.dart';
import '../../../shared/models/sage_model.dart';
import '../../../shared/providers/sage_provider.dart';
import '../../../core/constants/app_constants.dart';

class MysticRoundtableSection extends ConsumerStatefulWidget {
  final AnimationController celestialController;
  final AnimationController pulseController;
  final VoidCallback onStartRoundtable;

  const MysticRoundtableSection({
    super.key,
    required this.celestialController,
    required this.pulseController,
    required this.onStartRoundtable,
  });

  @override
  ConsumerState<MysticRoundtableSection> createState() => _MysticRoundtableSectionState();
}

class _MysticRoundtableSectionState extends ConsumerState<MysticRoundtableSection> {
  int _selectedSageIndex = 0;
  final TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sageState = ref.watch(sageProvider);
    final sages = sageState.sages;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: AnimatedBuilder(
          animation: widget.celestialController,
          builder: (context, child) {
            return GlassmorphicContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(24),
              gradientColors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.05),
              ],
              borderColor: Colors.white.withOpacity(0.3),
              borderWidth: 1,
              blurSigma: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.forum_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.purple.withOpacity(0.8),
                                  Colors.white,
                                ],
                                stops: [
                                  0.0,
                                  (widget.celestialController.value * 2) % 1.0,
                                  1.0,
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                '현자들의 원탁',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '6명의 현자가 모여 당신의 질문에 답합니다',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 3D Carousel - 현자들의 원탁
                  if (sages.isNotEmpty) ...[
                    Center(
                      child: Text(
                        '현자를 선택하고 질문해보세요',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    SizedBox(
                      height: 350,
                      child: Carousel3D(
                        children: sages.map((sage) => SageProfileCard(
                          sage: sage,
                          isSelected: sages.indexOf(sage) == _selectedSageIndex,
                          onTap: () {
                            setState(() {
                              _selectedSageIndex = sages.indexOf(sage);
                            });
                          },
                        )).toList(),
                        height: 350,
                        itemWidth: 200,
                        itemHeight: 300,
                        radius: 180,
                        initialIndex: _selectedSageIndex,
                        onItemSelected: (index) {
                          setState(() {
                            _selectedSageIndex = index;
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 선택된 현자 정보
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '선택된 현자: ${sages[_selectedSageIndex].displayName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sages[_selectedSageIndex].mood ?? '상담 가능',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 32),
                  
                  // 질문 입력 필드
                  GlassmorphicContainer(
                    borderRadius: BorderRadius.circular(16),
                    gradientColors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                    borderColor: Colors.white.withOpacity(0.3),
                    blurSigma: 5,
                    child: TextField(
                      controller: _questionController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: sages.isNotEmpty 
                            ? '${sages[_selectedSageIndex].displayName}에게 질문하거나, 모든 현자에게 원탁을 요청하세요...\n\n예: "나의 인생에서 가장 중요한 것은 무엇인가요?"'
                            : '현자들에게 질문하세요...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 액션 버튼들
                  Row(
                    children: [
                      // 개별 상담 버튼
                      if (sages.isNotEmpty)
                        Expanded(
                          child: GlassmorphicContainer(
                            height: 56,
                            borderRadius: BorderRadius.circular(16),
                            gradientColors: [
                              Color(int.parse(sages[_selectedSageIndex].primaryColor.replaceFirst('#', '0xFF')))
                                  .withOpacity(0.3),
                              Color(int.parse(sages[_selectedSageIndex].primaryColor.replaceFirst('#', '0xFF')))
                                  .withOpacity(0.1),
                            ],
                            borderColor: Colors.white.withOpacity(0.3),
                            borderWidth: 1,
                            blurSigma: 5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                // 개별 현자와 대화 시작
                                if (_questionController.text.trim().isNotEmpty) {
                                  // TODO: Navigate to individual sage conversation
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '개별 상담',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      
                      if (sages.isNotEmpty) const SizedBox(width: 12),
                      
                      // 원탁 시작 버튼
                      Expanded(
                        child: AnimatedBuilder(
                          animation: widget.pulseController,
                          builder: (context, child) {
                            return GlassmorphicContainer(
                              height: 56,
                              borderRadius: BorderRadius.circular(16),
                              gradientColors: [
                                Colors.purple.withOpacity(0.4),
                                Colors.blue.withOpacity(0.3),
                              ],
                              borderColor: Colors.white.withOpacity(0.5 + widget.pulseController.value * 0.3),
                              borderWidth: 1,
                              blurSigma: 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  if (_questionController.text.trim().isNotEmpty) {
                                    widget.onStartRoundtable();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.forum,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      '원탁 시작',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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