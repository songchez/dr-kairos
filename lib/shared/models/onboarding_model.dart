import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_model.freezed.dart';
part 'onboarding_model.g.dart';

@freezed
class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    String? name,
    String? email,
    DateTime? birthDate,
    String? birthTime,
    String? birthPlace,
    String? gender,
    @Default([]) List<String> interests,
    @Default([]) List<String> concerns,
    String? profileImagePath,
  }) = _OnboardingData;

  factory OnboardingData.fromJson(Map<String, dynamic> json) => _$OnboardingDataFromJson(json);
}

@freezed
class OnboardingStep with _$OnboardingStep {
  const factory OnboardingStep({
    required int stepNumber,
    required String title,
    required String subtitle,
    String? description,
    @Default(false) bool isCompleted,
    @Default(false) bool isRequired,
  }) = _OnboardingStep;

  factory OnboardingStep.fromJson(Map<String, dynamic> json) => _$OnboardingStepFromJson(json);
}

enum OnboardingStepType {
  welcome,
  personalInfo,
  birthInfo,
  interests,
  concerns,
  profilePhoto,
  complete,
}

class OnboardingSteps {
  static List<OnboardingStep> getSteps() {
    return [
      const OnboardingStep(
        stepNumber: 0,
        title: '환영합니다',
        subtitle: '당신만의 별자리를 만들어보세요',
        description: 'KAIROS와 7명의 현자들이 당신의 여정을 함께 할 준비가 되어있습니다.',
        isRequired: false,
      ),
      const OnboardingStep(
        stepNumber: 1,
        title: '기본 정보',
        subtitle: '당신에 대해 알려주세요',
        description: '현자들이 더 나은 조언을 드릴 수 있도록 도와주세요.',
        isRequired: true,
      ),
      const OnboardingStep(
        stepNumber: 2,
        title: '출생 정보',
        subtitle: '별들의 배치를 확인해보세요',
        description: '정확한 출생 정보는 더 정밀한 분석을 가능하게 합니다.',
        isRequired: true,
      ),
      const OnboardingStep(
        stepNumber: 3,
        title: '관심 분야',
        subtitle: '어떤 것들에 관심이 있나요?',
        description: '관심사를 바탕으로 맞춤형 조언을 제공해드립니다.',
        isRequired: false,
      ),
      const OnboardingStep(
        stepNumber: 4,
        title: '고민거리',
        subtitle: '현재 어떤 고민이 있나요?',
        description: '현자들이 우선적으로 도움을 드릴 수 있습니다.',
        isRequired: false,
      ),
      const OnboardingStep(
        stepNumber: 5,
        title: '프로필 사진',
        subtitle: '관상 분석을 위한 사진을 등록해보세요',
        description: '솔론 현자의 관상학 분석에 활용됩니다. (선택사항)',
        isRequired: false,
      ),
      const OnboardingStep(
        stepNumber: 6,
        title: '완료',
        subtitle: '별자리가 완성되었습니다!',
        description: '이제 현자들과의 여정을 시작할 수 있습니다.',
        isRequired: false,
      ),
    ];
  }
  
  static OnboardingStepType getStepType(int stepNumber) {
    switch (stepNumber) {
      case 0: return OnboardingStepType.welcome;
      case 1: return OnboardingStepType.personalInfo;
      case 2: return OnboardingStepType.birthInfo;
      case 3: return OnboardingStepType.interests;
      case 4: return OnboardingStepType.concerns;
      case 5: return OnboardingStepType.profilePhoto;
      case 6: return OnboardingStepType.complete;
      default: return OnboardingStepType.welcome;
    }
  }
}

// 미리 정의된 관심사 및 고민 카테고리
class OnboardingOptions {
  static const List<String> interests = [
    '사랑과 인간관계',
    '직업과 진로',
    '건강과 웰빙',
    '돈과 재정관리',
    '가족 관계',
    '자기계발',
    '영성과 명상',
    '미래 계획',
    '창작과 예술',
    '여행과 모험',
  ];

  static const List<String> concerns = [
    '진로 결정의 어려움',
    '인간관계 갈등',
    '경제적 불안',
    '건강 문제',
    '가족 문제',
    '자신감 부족',
    '미래에 대한 불안',
    '결정 장애',
    '번아웃과 스트레스',
    '외로움과 고립감',
  ];

  static const List<String> genderOptions = [
    '남성',
    '여성',
    '기타',
    '선택하지 않음',
  ];
}