// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestModelImpl _$$QuestModelImplFromJson(Map<String, dynamic> json) =>
    _$QuestModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$QuestCategoryEnumMap, json['category']),
      difficulty: $enumDecode(_$QuestDifficultyEnumMap, json['difficulty']),
      suggestedBy: $enumDecode(_$SageTypeEnumMap, json['suggestedBy']),
      experiencePoints: (json['experiencePoints'] as num).toInt(),
      estimatedTime:
          Duration(microseconds: (json['estimatedTime'] as num).toInt()),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      rewards:
          (json['rewards'] as List<dynamic>).map((e) => e as String).toList(),
      status: $enumDecodeNullable(_$QuestStatusEnumMap, json['status']) ??
          QuestStatus.available,
      completedSteps: (json['completedSteps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      userNote: json['userNote'] as String?,
      progress: (json['progress'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$QuestModelImplToJson(_$QuestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$QuestCategoryEnumMap[instance.category]!,
      'difficulty': _$QuestDifficultyEnumMap[instance.difficulty]!,
      'suggestedBy': _$SageTypeEnumMap[instance.suggestedBy]!,
      'experiencePoints': instance.experiencePoints,
      'estimatedTime': instance.estimatedTime.inMicroseconds,
      'steps': instance.steps,
      'rewards': instance.rewards,
      'status': _$QuestStatusEnumMap[instance.status]!,
      'completedSteps': instance.completedSteps,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'userNote': instance.userNote,
      'progress': instance.progress,
    };

const _$QuestCategoryEnumMap = {
  QuestCategory.selfReflection: 'selfReflection',
  QuestCategory.creativity: 'creativity',
  QuestCategory.relationships: 'relationships',
  QuestCategory.career: 'career',
  QuestCategory.health: 'health',
  QuestCategory.spirituality: 'spirituality',
  QuestCategory.learning: 'learning',
  QuestCategory.adventure: 'adventure',
};

const _$QuestDifficultyEnumMap = {
  QuestDifficulty.easy: 'easy',
  QuestDifficulty.medium: 'medium',
  QuestDifficulty.hard: 'hard',
  QuestDifficulty.epic: 'epic',
};

const _$SageTypeEnumMap = {
  SageType.stella: 'stella',
  SageType.solon: 'solon',
  SageType.orion: 'orion',
  SageType.drKairos: 'drKairos',
  SageType.gaia: 'gaia',
  SageType.selena: 'selena',
};

const _$QuestStatusEnumMap = {
  QuestStatus.available: 'available',
  QuestStatus.active: 'active',
  QuestStatus.completed: 'completed',
  QuestStatus.expired: 'expired',
};
