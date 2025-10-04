import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/sage_model.dart';
import '../../core/constants/sage_constants.dart';

part 'sage_provider.freezed.dart';

@freezed
class SageState with _$SageState {
  const factory SageState({
    @Default([]) List<SageModel> sages,
    SageModel? selectedSage,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SageState;
}

class SageNotifier extends StateNotifier<SageState> {
  SageNotifier() : super(const SageState()) {
    _initializeSages();
  }

  void _initializeSages() {
    print('🧙‍♀️ SageProvider: 현자들 초기화 시작');
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final sages = SageFactory.createAllSages();
      print('🧙‍♀️ SageProvider: ${sages.length}명의 현자 생성 완료');
      state = state.copyWith(
        sages: sages,
        isLoading: false,
      );
    } catch (e) {
      print('❌ SageProvider: 현자 초기화 오류 - $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '현자들을 불러오는 중 오류가 발생했습니다: $e',
      );
    }
  }

  void selectSage(String sageId) {
    final sage = SageFactory.getSageById(sageId);
    if (sage != null) {
      state = state.copyWith(selectedSage: sage);
    }
  }

  void selectSageByType(SageType type) {
    final sage = SageFactory.getSageByType(type);
    if (sage != null) {
      state = state.copyWith(selectedSage: sage);
    }
  }

  void clearSelection() {
    state = state.copyWith(selectedSage: null);
  }

  void updateSageInteraction(String sageId) {
    final updatedSages = state.sages.map((sage) {
      if (sage.id == sageId) {
        return sage.copyWith(
          interactionCount: sage.interactionCount + 1,
          lastInteraction: DateTime.now().toIso8601String(),
        );
      }
      return sage;
    }).toList();

    state = state.copyWith(sages: updatedSages);

    // 선택된 현자도 업데이트
    if (state.selectedSage?.id == sageId) {
      final updatedSelectedSage = updatedSages.firstWhere((sage) => sage.id == sageId);
      state = state.copyWith(selectedSage: updatedSelectedSage);
    }
  }

  void updateSageTrust(String sageId, double trustDelta) {
    final updatedSages = state.sages.map((sage) {
      if (sage.id == sageId) {
        final newTrust = (sage.trustLevel + trustDelta).clamp(0.0, 1.0);
        return sage.copyWith(trustLevel: newTrust);
      }
      return sage;
    }).toList();

    state = state.copyWith(sages: updatedSages);

    // 선택된 현자도 업데이트
    if (state.selectedSage?.id == sageId) {
      final updatedSelectedSage = updatedSages.firstWhere((sage) => sage.id == sageId);
      state = state.copyWith(selectedSage: updatedSelectedSage);
    }
  }

  void updateSageAvailability(String sageId, bool isAvailable) {
    final updatedSages = state.sages.map((sage) {
      if (sage.id == sageId) {
        return sage.copyWith(isAvailable: isAvailable);
      }
      return sage;
    }).toList();

    state = state.copyWith(sages: updatedSages);
  }

  List<SageModel> getRecommendedSages() {
    return state.sages
        .where((sage) => sage.isAvailable)
        .toList()
      ..sort((a, b) {
        // 신뢰도와 상호작용 횟수를 고려한 추천 점수
        final scoreA = a.trustLevel * 0.7 + (a.interactionCount / 100) * 0.3;
        final scoreB = b.trustLevel * 0.7 + (b.interactionCount / 100) * 0.3;
        return scoreB.compareTo(scoreA);
      });
  }

  List<SageModel> searchSages(String query) {
    if (query.isEmpty) return state.sages;

    final lowerQuery = query.toLowerCase();
    return state.sages.where((sage) {
      return sage.name.toLowerCase().contains(lowerQuery) ||
             sage.description.toLowerCase().contains(lowerQuery) ||
             sage.specialty.toLowerCase().contains(lowerQuery) ||
             sage.keywords.any((keyword) => keyword.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}

// 프로바이더들
final sageProvider = StateNotifierProvider<SageNotifier, SageState>(
  (ref) => SageNotifier(),
);

final selectedSageProvider = Provider<SageModel?>((ref) {
  return ref.watch(sageProvider).selectedSage;
});

final availableSagesProvider = Provider<List<SageModel>>((ref) {
  return ref.watch(sageProvider).sages.where((sage) => sage.isAvailable).toList();
});

final recommendedSagesProvider = Provider<List<SageModel>>((ref) {
  return ref.read(sageProvider.notifier).getRecommendedSages();
});

final sageSearchProvider = StateProvider<String>((ref) => '');

final filteredSagesProvider = Provider<List<SageModel>>((ref) {
  final query = ref.watch(sageSearchProvider);
  return ref.read(sageProvider.notifier).searchSages(query);
});