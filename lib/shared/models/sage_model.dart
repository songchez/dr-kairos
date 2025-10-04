import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/sage_constants.dart';

part 'sage_model.freezed.dart';
part 'sage_model.g.dart';

@freezed
class SageModel with _$SageModel {
  const factory SageModel({
    required String id,
    required SageType type,
    required String name,
    required String description,
    required String specialty,
    required List<String> keywords,
    required String avatarPath,
    required String backgroundPath,
    required String primaryColor,
    @Default(true) bool isAvailable,
    @Default(0) int interactionCount,
    @Default(0.0) double trustLevel,
    String? lastInteraction,
    String? mood,
  }) = _SageModel;

  factory SageModel.fromJson(Map<String, dynamic> json) => _$SageModelFromJson(json);
}

extension SageModelExtension on SageModel {
  String get displayName => SageConstants.sageNames[type] ?? name;
  
  String get fullDescription => SageConstants.sageDescriptions[type] ?? description;
  
  List<String> get defaultKeywords => SageConstants.sageKeywords[type] ?? keywords;
  
  String get specialtyArea => SageConstants.sageSpecialties[type] ?? specialty;
  
  String get imagePath => SageConstants.sageImages[type] ?? avatarPath;
  
  bool get isHighTrust => trustLevel >= 0.7;
  
  bool get isFrequentlyUsed => interactionCount >= 10;
  
  String get statusMessage {
    if (!isAvailable) return '현재 다른 상담 중입니다';
    if (mood != null) return mood!;
    return '언제든 상담 가능합니다';
  }
}

class SageFactory {
  static List<SageModel> createAllSages() {
    return [
      SageModel(
        id: 'stella',
        type: SageType.stella,
        name: '스텔라',
        description: '서양 점성술의 지혜로운 안내자',
        specialty: '점성술, 별자리, 운명의 흐름',
        keywords: ['별', '운명', '우주', '조화', '사랑', '성장'],
        avatarPath: 'assets/sages/Stella.jpg',
        backgroundPath: 'assets/images/backgrounds/stella_sanctum.png',
        primaryColor: '#FFD700',
        mood: '별들이 당신을 위해 반짝이고 있어요',
      ),
      SageModel(
        id: 'solon',
        type: SageType.solon,
        name: '솔론',
        description: '동양 사주명리학의 지혜로운 전략가',
        specialty: '사주명리학, 관상학, 인생 전략',
        keywords: ['지혜', '전략', '균형', '시간', '기회', '선택'],
        avatarPath: 'assets/sages/solon.png',
        backgroundPath: 'assets/images/backgrounds/solon_sanctum.png',
        primaryColor: '#8B4513',
        mood: '인생의 흐름을 읽어드리겠습니다',
      ),
      SageModel(
        id: 'orion',
        type: SageType.orion,
        name: '오리온',
        description: '타로카드의 신비로운 통찰가',
        specialty: '타로카드, 상징 해석, 직관적 통찰',
        keywords: ['직감', '변화', '숨겨진 진실', '내면', '깨달음'],
        avatarPath: 'assets/sages/Orion.png',
        backgroundPath: 'assets/images/backgrounds/orion_sanctum.png',
        primaryColor: '#9370DB',
        mood: '카드들이 당신의 이야기를 들려주고 있네요',
      ),
      SageModel(
        id: 'dr_kairos',
        type: SageType.drKairos,
        name: '닥터 카이로스',
        description: '현대 심리학의 논리적 상담가',
        specialty: '심리학, 인지행동치료, 논리적 분석',
        keywords: ['논리', '해결', '성장', '치유', '이해', '발전'],
        avatarPath: 'assets/sages/Dr. Kairos.png',
        backgroundPath: 'assets/images/backgrounds/kairos_sanctum.png',
        primaryColor: '#4169E1',
        mood: '함께 문제를 체계적으로 분석해보죠',
      ),
      SageModel(
        id: 'gaia',
        type: SageType.gaia,
        name: '가이아',
        description: '풍수지리와 자연의 대변자',
        specialty: '풍수지리, 주역, 환경과의 조화',
        keywords: ['자연', '조화', '흐름', '안정', '근본', '터전'],
        avatarPath: 'assets/sages/Gaia.png',
        backgroundPath: 'assets/images/backgrounds/gaia_sanctum.png',
        primaryColor: '#228B22',
        mood: '자연의 기운이 당신을 감싸고 있어요',
      ),
      SageModel(
        id: 'selena',
        type: SageType.selena,
        name: '셀레나',
        description: '달의 주기와 달력술의 신비로운 여신',
        specialty: '달력술, 꿈 해몽, 정서적 치유',
        keywords: ['달', '주기', '감정', '직관', '균형', '정화'],
        avatarPath: 'assets/sages/Selena.jpg',
        backgroundPath: 'assets/images/backgrounds/selena_sanctum.png',
        primaryColor: '#E6E6FA',
        mood: '달빛이 당신의 마음을 비춥니다',
      ),
    ];
  }
  
  static SageModel? getSageById(String id) {
    try {
      return createAllSages().firstWhere((sage) => sage.id == id);
    } catch (e) {
      return null;
    }
  }
  
  static SageModel? getSageByType(SageType type) {
    try {
      return createAllSages().firstWhere((sage) => sage.type == type);
    } catch (e) {
      return null;
    }
  }
}