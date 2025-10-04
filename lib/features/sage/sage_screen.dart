import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../shared/widgets/cosmic_background.dart';
import '../../shared/widgets/sage_avatar.dart';
import '../../shared/providers/sage_provider.dart';
import '../../shared/models/sage_model.dart';
import '../../core/utils/app_router.dart';
import '../../core/constants/app_constants.dart';

class SageScreen extends ConsumerStatefulWidget {
  final String sageId;

  const SageScreen({super.key, required this.sageId});

  @override
  ConsumerState<SageScreen> createState() => _SageScreenState();
}

class _SageScreenState extends ConsumerState<SageScreen> {
  @override
  void initState() {
    super.initState();
    // 현자 선택
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sageProvider.notifier).selectSage(widget.sageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedSage = ref.watch(selectedSageProvider);
    
    if (selectedSage == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CosmicBackground(
        gradientColors: _getSageGradientColors(selectedSage),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(selectedSage),
              _buildSageIntro(selectedSage),
              _buildActionButtons(selectedSage),
              _buildSageInfo(selectedSage),
              _buildRecentActivity(selectedSage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(SageModel sage) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      expandedHeight: 120,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          sage.displayName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _buildSageIntro(SageModel sage) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: CustomAnimationBuilder<double>(
          control: Control.play,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOut,
          builder: (context, value, _) {
            return Opacity(
              opacity: value,
              child: Column(
                children: [
                  // 현자 아바타
                  SageAvatar(
                    sage: sage,
                    size: 120,
                    isActive: true,
                    showStatus: false,
                  ),
                  const SizedBox(height: 24),
                  
                  // 현자 설명
                  Text(
                    sage.fullDescription,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  // 전문 분야
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _parseColor(sage.primaryColor).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _parseColor(sage.primaryColor).withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      sage.specialtyArea,
                      style: TextStyle(
                        color: _parseColor(sage.primaryColor),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 현재 상태
                  Text(
                    sage.statusMessage,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons(SageModel sage) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: CustomAnimationBuilder<double>(
          control: Control.play,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          builder: (context, value, _) {
            return Opacity(
              opacity: value,
              child: Column(
                children: [
                  // 대화 시작 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: sage.isAvailable 
                          ? () => _startConversation(sage)
                          : null,
                      icon: const Icon(Icons.chat),
                      label: const Text('대화 시작하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _parseColor(sage.primaryColor),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // 추가 액션 버튼들
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showSageProfile(sage),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('프로필'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showPastConversations(sage),
                          icon: const Icon(Icons.history),
                          label: const Text('대화 기록'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
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

  Widget _buildSageInfo(SageModel sage) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: CustomAnimationBuilder<double>(
          control: Control.play,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          builder: (context, value, _) {
            return Opacity(
              opacity: value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '특징',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 키워드 태그들
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: sage.defaultKeywords.map((keyword) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          keyword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // 통계 정보
                  _buildStatsCard(sage),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatsCard(SageModel sage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '상담 통계',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('총 상담', '${sage.interactionCount}회'),
              ),
              Expanded(
                child: _buildStatItem('신뢰도', '${(sage.trustLevel * 100).toInt()}%'),
              ),
              Expanded(
                child: _buildStatItem(
                  '상태',
                  sage.isAvailable ? '상담 가능' : '상담 중',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(SageModel sage) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: CustomAnimationBuilder<double>(
          control: Control.play,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
          builder: (context, value, _) {
            return Opacity(
              opacity: value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '최근 조언',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Text(
                      '아직 ${sage.displayName}와의 대화 기록이 없습니다.\n첫 번째 대화를 시작해보세요!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
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

  List<Color> _getSageGradientColors(SageModel sage) {
    final primaryColor = _parseColor(sage.primaryColor);
    return [
      const Color(0xFF0F0B1A),
      primaryColor.withOpacity(0.3),
      primaryColor.withOpacity(0.1),
    ];
  }

  Color _parseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.amber;
    }
  }

  void _startConversation(SageModel sage) {
    // 상호작용 횟수 증가
    ref.read(sageProvider.notifier).updateSageInteraction(sage.id);
    
    // 대화 화면으로 이동
    context.push(AppRouter.conversationRoute(sage.id));
  }

  void _showSageProfile(SageModel sage) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1625),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${sage.displayName} 프로필',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              sage.fullDescription,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '전문 분야: ${sage.specialtyArea}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPastConversations(SageModel sage) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('대화 기록 기능을 준비 중입니다')),
    );
  }
}