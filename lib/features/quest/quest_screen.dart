import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../shared/widgets/cosmic_background.dart';
import '../../shared/providers/quest_provider.dart';
import '../../shared/providers/app_state_provider.dart';
import '../../data/models/quest_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';

class QuestScreen extends ConsumerStatefulWidget {
  const QuestScreen({super.key});

  @override
  ConsumerState<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends ConsumerState<QuestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // 퀘스트 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = ref.read(appStateProvider).currentUserId ?? 'demo_user';
      // 퀘스트가 없으면 생성
      final questState = ref.read(questProvider(userId));
      if (questState.quests.isEmpty) {
        ref.read(questProvider(userId).notifier).generateDailyQuests();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(appStateProvider).currentUserId ?? 'demo_user';
    final questState = ref.watch(questProvider(userId));
    final totalPoints = ref.watch(totalPointsProvider(userId));

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(totalPoints),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildActiveQuests(questState, userId),
                    _buildCompletedQuests(questState, userId),
                    _buildQuestGenerator(userId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int totalPoints) {
    return CustomAnimationBuilder<double>(
      control: Control.play,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '라이프 퀘스트',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.stars,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$totalPoints',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '현자들이 제안하는 성장의 여정',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(25),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        tabs: const [
          Tab(text: '진행 중'),
          Tab(text: '완료'),
          Tab(text: '새 퀘스트'),
        ],
      ),
    );
  }

  Widget _buildActiveQuests(QuestState questState, String userId) {
    if (questState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (questState.activeQuests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.assignment,
        title: '진행 중인 퀘스트가 없습니다',
        subtitle: '새로운 퀘스트를 시작해보세요!',
        action: () => _tabController.animateTo(2),
        actionLabel: '퀘스트 생성',
      );
    }

    return CustomAnimationBuilder<double>(
      control: Control.play,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: questState.activeQuests.length,
            itemBuilder: (context, index) {
              final quest = questState.activeQuests[index];
              return _buildQuestCard(quest, userId, isActive: true);
            },
          ),
        );
      },
    );
  }

  Widget _buildCompletedQuests(QuestState questState, String userId) {
    if (questState.completedQuests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.emoji_events,
        title: '완료된 퀘스트가 없습니다',
        subtitle: '첫 번째 퀘스트를 완료해보세요!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: questState.completedQuests.length,
      itemBuilder: (context, index) {
        final quest = questState.completedQuests[index];
        return _buildQuestCard(quest, userId, isActive: false);
      },
    );
  }

  Widget _buildQuestGenerator(String userId) {
    return CustomAnimationBuilder<double>(
      control: Control.play,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '새로운 퀘스트',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildGeneratorCard(
                  title: '일일 퀘스트',
                  subtitle: '매일 새로운 도전과 성장',
                  icon: Icons.today,
                  color: Colors.blue,
                  onTap: () => ref.read(questProvider(userId).notifier).generateDailyQuests(),
                ),
                
                const SizedBox(height: 16),
                
                _buildGeneratorCard(
                  title: '주간 퀘스트',
                  subtitle: '일주일간의 깊은 변화',
                  icon: Icons.date_range,
                  color: Colors.purple,
                  onTap: () => _generateWeeklyQuests(userId),
                ),
                
                const SizedBox(height: 16),
                
                _buildGeneratorCard(
                  title: '맞춤형 퀘스트',
                  subtitle: '당신의 관심사와 고민을 반영',
                  icon: Icons.psychology,
                  color: Colors.orange,
                  onTap: () => _generatePersonalizedQuests(userId),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGeneratorCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestCard(QuestModel quest, String userId, {required bool isActive}) {
    final difficultyColor = _getDifficultyColor(quest.difficulty);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive 
              ? difficultyColor.withOpacity(0.5)
              : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  quest.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: isActive ? null : TextDecoration.lineThrough,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: difficultyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getDifficultyText(quest.difficulty),
                  style: TextStyle(
                    color: difficultyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 설명
          Text(
            quest.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 진행률
          if (isActive) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '진행률: ${quest.currentProgress}/${quest.targetCount}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${(quest.progressPercentage * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: quest.progressPercentage,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(difficultyColor),
            ),
            const SizedBox(height: 12),
          ],
          
          // 액션 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 보상 표시
              Row(
                children: [
                  const Icon(
                    Icons.stars,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${quest.rewardPoints}',
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              // 액션 버튼
              if (isActive) ...[
                Row(
                  children: [
                    if (quest.currentProgress < quest.targetCount)
                      ElevatedButton(
                        onPressed: () => _updateProgress(quest, userId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: difficultyColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text('진행'),
                      ),
                    if (quest.isCompleted)
                      ElevatedButton(
                        onPressed: () => _completeQuest(quest, userId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text('완료'),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? action,
    String? actionLabel,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null && actionLabel != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: action,
              child: Text(actionLabel),
            ),
          ],
        ],
      ),
    );
  }

  Color _getDifficultyColor(QuestDifficulty difficulty) {
    switch (difficulty) {
      case QuestDifficulty.easy:
        return Colors.green;
      case QuestDifficulty.medium:
        return Colors.orange;
      case QuestDifficulty.hard:
        return Colors.red;
    }
  }

  String _getDifficultyText(QuestDifficulty difficulty) {
    switch (difficulty) {
      case QuestDifficulty.easy:
        return '쉬움';
      case QuestDifficulty.medium:
        return '보통';
      case QuestDifficulty.hard:
        return '어려움';
    }
  }

  void _updateProgress(QuestModel quest, String userId) {
    final newProgress = quest.currentProgress + 1;
    ref.read(questProvider(userId).notifier).updateQuestProgress(
      quest.questId,
      newProgress,
    );
  }

  void _completeQuest(QuestModel quest, String userId) {
    ref.read(questProvider(userId).notifier).completeQuest(quest.questId);
    
    // 완료 축하 메시지
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('퀘스트 완료! ${quest.rewardPoints} 포인트를 획득했습니다!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _generateWeeklyQuests(String userId) {
    // 주간 퀘스트 생성 로직 (현재는 일일 퀘스트와 동일)
    ref.read(questProvider(userId).notifier).generateDailyQuests();
  }

  void _generatePersonalizedQuests(String userId) {
    // 맞춤형 퀘스트 생성 로직
    ref.read(questProvider(userId).notifier).generateDailyQuests();
  }
}