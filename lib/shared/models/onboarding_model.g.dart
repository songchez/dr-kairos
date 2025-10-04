// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingDataImpl _$$OnboardingDataImplFromJson(Map<String, dynamic> json) =>
    _$OnboardingDataImpl(
      name: json['name'] as String?,
      email: json['email'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      birthTime: json['birthTime'] as String?,
      birthPlace: json['birthPlace'] as String?,
      gender: json['gender'] as String?,
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      concerns: (json['concerns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      profileImagePath: json['profileImagePath'] as String?,
    );

Map<String, dynamic> _$$OnboardingDataImplToJson(
        _$OnboardingDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'birthDate': instance.birthDate?.toIso8601String(),
      'birthTime': instance.birthTime,
      'birthPlace': instance.birthPlace,
      'gender': instance.gender,
      'interests': instance.interests,
      'concerns': instance.concerns,
      'profileImagePath': instance.profileImagePath,
    };

_$OnboardingStepImpl _$$OnboardingStepImplFromJson(Map<String, dynamic> json) =>
    _$OnboardingStepImpl(
      stepNumber: (json['stepNumber'] as num).toInt(),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isRequired: json['isRequired'] as bool? ?? false,
    );

Map<String, dynamic> _$$OnboardingStepImplToJson(
        _$OnboardingStepImpl instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isRequired': instance.isRequired,
    };
