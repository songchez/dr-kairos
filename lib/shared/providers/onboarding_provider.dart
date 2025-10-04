import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/onboarding_model.dart';
import '../../data/models/user_model.dart';
import '../services/database_service.dart';

part 'onboarding_provider.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentStep,
    @Default(OnboardingData()) OnboardingData data,
    @Default([]) List<OnboardingStep> steps,
    @Default([]) List<bool> completedSteps,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _OnboardingState;
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final DatabaseService _databaseService;

  OnboardingNotifier(this._databaseService) : super(const OnboardingState()) {
    _initializeSteps();
  }

  void _initializeSteps() {
    final steps = OnboardingSteps.getSteps();
    final completedSteps = List.generate(steps.length, (index) => false);
    
    state = state.copyWith(
      steps: steps,
      completedSteps: completedSteps,
    );
  }

  void nextStep() {
    if (state.currentStep < state.steps.length - 1) {
      // 현재 스텝을 완료로 표시
      final updatedCompleted = List<bool>.from(state.completedSteps);
      updatedCompleted[state.currentStep] = true;

      state = state.copyWith(
        currentStep: state.currentStep + 1,
        completedSteps: updatedCompleted,
      );
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void goToStep(int stepIndex) {
    if (stepIndex >= 0 && stepIndex < state.steps.length) {
      state = state.copyWith(currentStep: stepIndex);
    }
  }

  void updatePersonalInfo({
    String? name,
    String? email,
    String? gender,
  }) {
    state = state.copyWith(
      data: state.data.copyWith(
        name: name ?? state.data.name,
        email: email ?? state.data.email,
        gender: gender ?? state.data.gender,
      ),
    );
  }

  void updateBirthInfo({
    DateTime? birthDate,
    String? birthTime,
    String? birthPlace,
  }) {
    state = state.copyWith(
      data: state.data.copyWith(
        birthDate: birthDate ?? state.data.birthDate,
        birthTime: birthTime ?? state.data.birthTime,
        birthPlace: birthPlace ?? state.data.birthPlace,
      ),
    );
  }

  void updateInterests(List<String> interests) {
    state = state.copyWith(
      data: state.data.copyWith(interests: interests),
    );
  }

  void addInterest(String interest) {
    final currentInterests = List<String>.from(state.data.interests);
    if (!currentInterests.contains(interest)) {
      currentInterests.add(interest);
      updateInterests(currentInterests);
    }
  }

  void removeInterest(String interest) {
    final currentInterests = List<String>.from(state.data.interests);
    currentInterests.remove(interest);
    updateInterests(currentInterests);
  }

  void updateConcerns(List<String> concerns) {
    state = state.copyWith(
      data: state.data.copyWith(concerns: concerns),
    );
  }

  void addConcern(String concern) {
    final currentConcerns = List<String>.from(state.data.concerns);
    if (!currentConcerns.contains(concern)) {
      currentConcerns.add(concern);
      updateConcerns(currentConcerns);
    }
  }

  void removeConcern(String concern) {
    final currentConcerns = List<String>.from(state.data.concerns);
    currentConcerns.remove(concern);
    updateConcerns(currentConcerns);
  }

  void updateProfileImage(String? imagePath) {
    state = state.copyWith(
      data: state.data.copyWith(profileImagePath: imagePath),
    );
  }

  bool validateCurrentStep() {
    final currentStepData = state.steps[state.currentStep];
    
    if (!currentStepData.isRequired) return true;

    switch (OnboardingSteps.getStepType(state.currentStep)) {
      case OnboardingStepType.personalInfo:
        return state.data.name?.isNotEmpty == true;
      
      case OnboardingStepType.birthInfo:
        return state.data.birthDate != null;
      
      case OnboardingStepType.interests:
      case OnboardingStepType.concerns:
      case OnboardingStepType.profilePhoto:
        return true; // 선택사항
      
      default:
        return true;
    }
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 사용자 데이터를 UserModel로 변환
      final user = UserModel(
        name: state.data.name,
        email: state.data.email,
        birthDate: state.data.birthDate,
        birthTime: state.data.birthTime,
        birthPlace: state.data.birthPlace,
        gender: state.data.gender,
        profileImagePath: state.data.profileImagePath,
        firstLaunchDate: DateTime.now(),
        lastActiveDate: DateTime.now(),
      );

      user.userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      // 데이터베이스에 저장
      await DatabaseService.saveUser(user);

      // 모든 스텝을 완료로 표시
      final allCompleted = List.generate(state.steps.length, (index) => true);
      
      state = state.copyWith(
        isLoading: false,
        completedSteps: allCompleted,
        currentStep: state.steps.length - 1,
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '온보딩 완료 중 오류가 발생했습니다: $e',
      );
    }
  }

  void resetOnboarding() {
    state = const OnboardingState();
    _initializeSteps();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// 프로바이더들
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (ref) {
    final databaseService = ref.watch(databaseServiceProvider);
    return OnboardingNotifier(databaseService);
  },
);

final currentStepProvider = Provider<OnboardingStep>((ref) {
  final state = ref.watch(onboardingProvider);
  return state.steps.isNotEmpty ? state.steps[state.currentStep] : OnboardingSteps.getSteps().first;
});

final canProceedProvider = Provider<bool>((ref) {
  return ref.read(onboardingProvider.notifier).validateCurrentStep();
});

final onboardingProgressProvider = Provider<double>((ref) {
  final state = ref.watch(onboardingProvider);
  if (state.steps.isEmpty) return 0.0;
  return state.currentStep / (state.steps.length - 1);
});