// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SageModelImpl _$$SageModelImplFromJson(Map<String, dynamic> json) =>
    _$SageModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$SageTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String,
      specialty: json['specialty'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      avatarPath: json['avatarPath'] as String,
      backgroundPath: json['backgroundPath'] as String,
      primaryColor: json['primaryColor'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      interactionCount: (json['interactionCount'] as num?)?.toInt() ?? 0,
      trustLevel: (json['trustLevel'] as num?)?.toDouble() ?? 0.0,
      lastInteraction: json['lastInteraction'] as String?,
      mood: json['mood'] as String?,
    );

Map<String, dynamic> _$$SageModelImplToJson(_$SageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SageTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'specialty': instance.specialty,
      'keywords': instance.keywords,
      'avatarPath': instance.avatarPath,
      'backgroundPath': instance.backgroundPath,
      'primaryColor': instance.primaryColor,
      'isAvailable': instance.isAvailable,
      'interactionCount': instance.interactionCount,
      'trustLevel': instance.trustLevel,
      'lastInteraction': instance.lastInteraction,
      'mood': instance.mood,
    };

const _$SageTypeEnumMap = {
  SageType.stella: 'stella',
  SageType.solon: 'solon',
  SageType.orion: 'orion',
  SageType.drKairos: 'drKairos',
  SageType.gaia: 'gaia',
  SageType.selena: 'selena',
};
