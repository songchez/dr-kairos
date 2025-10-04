import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quest_model.dart';
import '../../core/constants/sage_constants.dart';

class QuestState {
  final List<QuestModel> allQuests;
  final List<QuestModel> activeQuests;
  final List<QuestModel> completedQuests;
  final bool isLoading;
  final String? error;
  final int totalExperience;

  const QuestState({
    this.allQuests = const [],
    this.activeQuests = const [],
    this.completedQuests = const [],
    this.isLoading = false,
    this.error,
    this.totalExperience = 0,
  });

  QuestState copyWith({
    List<QuestModel>? allQuests,
    List<QuestModel>? activeQuests,
    List<QuestModel>? completedQuests,
    bool? isLoading,
    String? error,
    int? totalExperience,
  }) {
    return QuestState(
      allQuests: allQuests ?? this.allQuests,
      activeQuests: activeQuests ?? this.activeQuests,
      completedQuests: completedQuests ?? this.completedQuests,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      totalExperience: totalExperience ?? this.totalExperience,
    );
  }
}

class QuestNotifier extends StateNotifier<QuestState> {
  QuestNotifier() : super(const QuestState()) {
    _loadQuests();
  }

  void _loadQuests() {
    state = state.copyWith(isLoading: true);
    
    try {
      final allQuests = QuestFactory.generateSampleQuests();
      final activeQuests = allQuests.where((q) => q.isActive).toList();
      final completedQuests = allQuests.where((q) => q.isCompleted).toList();
      final totalExp = completedQuests.fold<int>(0, (sum, quest) => sum + quest.experiencePoints);

      state = state.copyWith(
        allQuests: allQuests,
        activeQuests: activeQuests,
        completedQuests: completedQuests,
        totalExperience: totalExp,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '퀘스트를 불러오는데 실패했습니다: $e',
      );
    }
  }

  void startQuest(String questId) {
    final questIndex = state.allQuests.indexWhere((q) => q.id == questId);
    if (questIndex == -1) return;

    final quest = state.allQuests[questIndex];
    final updatedQuest = quest.copyWith(
      status: QuestStatus.active,
      startedAt: DateTime.now(),
    );

    final updatedAllQuests = [...state.allQuests];
    updatedAllQuests[questIndex] = updatedQuest;

    final updatedActiveQuests = [...state.activeQuests, updatedQuest];

    state = state.copyWith(
      allQuests: updatedAllQuests,
      activeQuests: updatedActiveQuests,
    );
  }

  void completeQuestStep(String questId, String step) {
    final questIndex = state.allQuests.indexWhere((q) => q.id == questId);
    if (questIndex == -1) return;

    final quest = state.allQuests[questIndex];
    if (!quest.isActive || quest.completedSteps.contains(step)) return;

    final updatedCompletedSteps = [...quest.completedSteps, step];
    final isFullyCompleted = updatedCompletedSteps.length == quest.steps.length;

    final updatedQuest = quest.copyWith(
      completedSteps: updatedCompletedSteps,
      status: isFullyCompleted ? QuestStatus.completed : QuestStatus.active,
      completedAt: isFullyCompleted ? DateTime.now() : null,
      progress: (updatedCompletedSteps.length / quest.steps.length * 100).round(),
    );

    final updatedAllQuests = [...state.allQuests];
    updatedAllQuests[questIndex] = updatedQuest;

    final updatedActiveQuests = state.activeQuests.map((q) =>
        q.id == questId ? updatedQuest : q).where((q) => q.isActive).toList();

    final updatedCompletedQuests = isFullyCompleted
        ? [...state.completedQuests, updatedQuest]
        : state.completedQuests;

    final updatedTotalExp = isFullyCompleted
        ? state.totalExperience + quest.experiencePoints
        : state.totalExperience;

    state = state.copyWith(
      allQuests: updatedAllQuests,
      activeQuests: updatedActiveQuests,
      completedQuests: updatedCompletedQuests,
      totalExperience: updatedTotalExp,
    );
  }

  List<QuestModel> getAvailableQuests() {
    return state.allQuests.where((q) => q.status == QuestStatus.available).toList();
  }
}

final questProvider = StateNotifierProvider<QuestNotifier, QuestState>((ref) {
  return QuestNotifier();
});

final activeQuestsProvider = Provider<List<QuestModel>>((ref) {
  return ref.watch(questProvider).activeQuests;
});

final completedQuestsProvider = Provider<List<QuestModel>>((ref) {
  return ref.watch(questProvider).completedQuests;
});

final totalExperienceProvider = Provider<int>((ref) {
  return ref.watch(questProvider).totalExperience;
});