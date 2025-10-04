import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/sage_constants.dart';

part 'quest_model.freezed.dart';
part 'quest_model.g.dart';

enum QuestStatus {
  available,
  active,
  completed,
  expired,
}

enum QuestDifficulty {
  easy,
  medium,
  hard,
  epic,
}

enum QuestCategory {
  selfReflection,
  creativity,
  relationships,
  career,
  health,
  spirituality,
  learning,
  adventure,
}

@freezed
class QuestModel with _$QuestModel {
  const factory QuestModel({
    required String id,
    required String title,
    required String description,
    required QuestCategory category,
    required QuestDifficulty difficulty,
    required SageType suggestedBy,
    required int experiencePoints,
    required Duration estimatedTime,
    required List<String> steps,
    required List<String> rewards,
    @Default(QuestStatus.available) QuestStatus status,
    @Default([]) List<String> completedSteps,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    String? userNote,
    @Default(0) int progress,
  }) = _QuestModel;

  factory QuestModel.fromJson(Map<String, dynamic> json) => 
      _$QuestModelFromJson(json);
}

extension QuestModelExtension on QuestModel {
  double get progressPercentage => 
      steps.isEmpty ? 0.0 : completedSteps.length / steps.length;

  bool get isCompleted => status == QuestStatus.completed;
  bool get isActive => status == QuestStatus.active;
  bool get isExpired => 
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  String get difficultyLabel {
    switch (difficulty) {
      case QuestDifficulty.easy:
        return '쉬움';
      case QuestDifficulty.medium:
        return '보통';
      case QuestDifficulty.hard:
        return '어려움';
      case QuestDifficulty.epic:
        return '전설';
    }
  }

  String get categoryLabel {
    switch (category) {
      case QuestCategory.selfReflection:
        return '자기성찰';
      case QuestCategory.creativity:
        return '창의성';
      case QuestCategory.relationships:
        return '인간관계';
      case QuestCategory.career:
        return '커리어';
      case QuestCategory.health:
        return '건강';
      case QuestCategory.spirituality:
        return '영성';
      case QuestCategory.learning:
        return '학습';
      case QuestCategory.adventure:
        return '모험';
    }
  }

  String get statusLabel {
    switch (status) {
      case QuestStatus.available:
        return '시작 가능';
      case QuestStatus.active:
        return '진행 중';
      case QuestStatus.completed:
        return '완료';
      case QuestStatus.expired:
        return '만료';
    }
  }
}

class QuestFactory {
  static List<QuestModel> generateSampleQuests() {
    return [
      // 스텔라 제안 퀘스트
      const QuestModel(
        id: 'stella_star_gazing',
        title: '별빛 명상',
        description: '밤하늘의 별을 바라보며 우주와 하나되는 시간을 가져보세요.',
        category: QuestCategory.spirituality,
        difficulty: QuestDifficulty.easy,
        suggestedBy: SageType.stella,
        experiencePoints: 150,
        estimatedTime: Duration(minutes: 30),
        steps: [
          '날씨가 맑은 밤을 선택하세요',
          '조용한 장소를 찾아가세요',
          '15분간 별을 바라보며 명상하세요',
          '느낀 점을 일기에 기록하세요',
        ],
        rewards: ['우주적 통찰력 +1', '평온함 증가', '별자리 지식'],
      ),

      // 솔론 제안 퀘스트
      const QuestModel(
        id: 'solon_life_strategy',
        title: '인생 전략 수립',
        description: '향후 5년간의 인생 로드맵을 체계적으로 설계해보세요.',
        category: QuestCategory.career,
        difficulty: QuestDifficulty.medium,
        suggestedBy: SageType.solon,
        experiencePoints: 300,
        estimatedTime: Duration(hours: 2),
        steps: [
          '현재 상황을 객관적으로 분석하기',
          '5년 후 목표 설정하기',
          '연도별 마일스톤 정하기',
          '구체적인 실행 계획 작성하기',
        ],
        rewards: ['전략적 사고력 향상', '목표 달성 확률 증가', '지혜 +2'],
      ),

      // 오리온 제안 퀘스트
      const QuestModel(
        id: 'orion_shadow_work',
        title: '그림자 탐구',
        description: '자신의 숨겨진 면을 발견하고 통합하는 여정을 시작하세요.',
        category: QuestCategory.selfReflection,
        difficulty: QuestDifficulty.hard,
        suggestedBy: SageType.orion,
        experiencePoints: 500,
        estimatedTime: Duration(days: 7),
        steps: [
          '싫어하는 사람의 특성 5가지 적기',
          '그 특성이 나에게도 있는지 성찰하기',
          '부정적 감정이 일어나는 패턴 관찰하기',
          '그림자를 받아들이는 의식 진행하기',
        ],
        rewards: ['자아 통합', '감정 조절력 향상', '직관력 +3'],
      ),

      // 닥터 카이로스 제안 퀘스트
      const QuestModel(
        id: 'kairos_cognitive_restructuring',
        title: '사고 패턴 개선',
        description: '부정적 사고 패턴을 찾아 건설적으로 바꿔보세요.',
        category: QuestCategory.health,
        difficulty: QuestDifficulty.medium,
        suggestedBy: SageType.drKairos,
        experiencePoints: 250,
        estimatedTime: Duration(days: 14),
        steps: [
          '일주일간 부정적 생각 기록하기',
          '인지 왜곡 패턴 찾아내기',
          '대안적 사고 연습하기',
          '긍정적 확언 만들어 실천하기',
        ],
        rewards: ['정신적 웰빙 향상', '스트레스 감소', '논리력 +2'],
      ),

      // 가이아 제안 퀘스트
      const QuestModel(
        id: 'gaia_nature_connection',
        title: '자연과의 재연결',
        description: '자연 속에서 시간을 보내며 대지의 에너지를 느껴보세요.',
        category: QuestCategory.spirituality,
        difficulty: QuestDifficulty.easy,
        suggestedBy: SageType.gaia,
        experiencePoints: 200,
        estimatedTime: Duration(hours: 4),
        steps: [
          '가까운 공원이나 숲 찾기',
          '휴대폰을 끄고 2시간 산책하기',
          '나무나 돌과 교감하기',
          '자연에서 받은 메시지 기록하기',
        ],
        rewards: ['자연과의 조화', '평화로움 증가', '접지력 향상'],
      ),

      // 셀레나 제안 퀘스트
      const QuestModel(
        id: 'selena_dream_journal',
        title: '꿈 일기 쓰기',
        description: '한 달간 꿈을 기록하고 무의식의 메시지를 해석해보세요.',
        category: QuestCategory.selfReflection,
        difficulty: QuestDifficulty.medium,
        suggestedBy: SageType.selena,
        experiencePoints: 350,
        estimatedTime: Duration(days: 30),
        steps: [
          '침대 옆에 일기장과 펜 준비하기',
          '매일 아침 꿈 내용 기록하기',
          '반복되는 상징이나 패턴 찾기',
          '꿈의 의미를 해석해보기',
        ],
        rewards: ['무의식과의 소통', '직관력 강화', '달의 지혜 +2'],
      ),
    ];
  }
}