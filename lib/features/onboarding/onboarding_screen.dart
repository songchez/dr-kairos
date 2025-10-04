import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/cosmic_background.dart';
import '../../shared/widgets/constellation_animation.dart';
import '../../shared/providers/onboarding_provider.dart';
import '../../shared/models/onboarding_model.dart';
import '../../core/utils/app_router.dart';
import '../../core/constants/app_constants.dart';

import 'widgets/welcome_step.dart';
import 'widgets/personal_info_step.dart';
import 'widgets/birth_info_step.dart';
import 'widgets/interests_step.dart';
import 'widgets/concerns_step.dart';
import 'widgets/profile_photo_step.dart';
import 'widgets/complete_step.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final currentStep = ref.watch(currentStepProvider);
    final canProceed = ref.watch(canProceedProvider);
    final progress = ref.watch(onboardingProgressProvider);

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, ref, currentStep, progress, onboardingState),
              Expanded(
                child: _buildStepContent(context, ref, onboardingState.currentStep),
              ),
              _buildNavigationButtons(context, ref, canProceed, onboardingState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    OnboardingStep currentStep,
    double progress,
    OnboardingState state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          // 별자리 진행 표시
          ConstellationProgress(
            totalSteps: state.steps.length,
            currentStep: state.currentStep,
            completedSteps: state.completedSteps,
          ),
          const SizedBox(height: 24),
          
          // 진행 바
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
          const SizedBox(height: 24),
          
          // 단계 제목
          Text(
            currentStep.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // 단계 부제목
          Text(
            currentStep.subtitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          
          if (currentStep.description?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Text(
              currentStep.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white60,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, WidgetRef ref, int currentStep) {
    final stepType = OnboardingSteps.getStepType(currentStep);
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(currentStep),
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        child: _getStepWidget(stepType),
      ),
    );
  }

  Widget _getStepWidget(OnboardingStepType stepType) {
    switch (stepType) {
      case OnboardingStepType.welcome:
        return const WelcomeStep();
      case OnboardingStepType.personalInfo:
        return const PersonalInfoStep();
      case OnboardingStepType.birthInfo:
        return const BirthInfoStep();
      case OnboardingStepType.interests:
        return const InterestsStep();
      case OnboardingStepType.concerns:
        return const ConcernsStep();
      case OnboardingStepType.profilePhoto:
        return const ProfilePhotoStep();
      case OnboardingStepType.complete:
        return const CompleteStep();
    }
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    WidgetRef ref,
    bool canProceed,
    OnboardingState state,
  ) {
    final isFirstStep = state.currentStep == 0;
    final isLastStep = state.currentStep == state.steps.length - 1;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Row(
        children: [
          // 이전 버튼
          if (!isFirstStep)
            Expanded(
              child: OutlinedButton(
                onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  '이전',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          
          if (!isFirstStep) const SizedBox(width: 16),
          
          // 다음/완료 버튼
          Expanded(
            flex: isFirstStep ? 1 : 1,
            child: ElevatedButton(
              onPressed: canProceed ? () => _handleNext(context, ref, isLastStep) : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              child: state.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : Text(
                      isLastStep ? '여정 시작하기' : '다음',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(BuildContext context, WidgetRef ref, bool isLastStep) {
    if (isLastStep) {
      _completeOnboarding(context, ref);
    } else {
      ref.read(onboardingProvider.notifier).nextStep();
    }
  }

  void _completeOnboarding(BuildContext context, WidgetRef ref) async {
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    
    final state = ref.read(onboardingProvider);
    if (state.errorMessage != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    
    // 홈 화면으로 이동
    if (context.mounted) {
      context.go(AppRouter.home);
    }
  }
}