// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnboardingData _$OnboardingDataFromJson(Map<String, dynamic> json) {
  return _OnboardingData.fromJson(json);
}

/// @nodoc
mixin _$OnboardingData {
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  String? get birthTime => throw _privateConstructorUsedError;
  String? get birthPlace => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  List<String> get concerns => throw _privateConstructorUsedError;
  String? get profileImagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingDataCopyWith<OnboardingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingDataCopyWith<$Res> {
  factory $OnboardingDataCopyWith(
          OnboardingData value, $Res Function(OnboardingData) then) =
      _$OnboardingDataCopyWithImpl<$Res, OnboardingData>;
  @useResult
  $Res call(
      {String? name,
      String? email,
      DateTime? birthDate,
      String? birthTime,
      String? birthPlace,
      String? gender,
      List<String> interests,
      List<String> concerns,
      String? profileImagePath});
}

/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res, $Val extends OnboardingData>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? birthTime = freezed,
    Object? birthPlace = freezed,
    Object? gender = freezed,
    Object? interests = null,
    Object? concerns = null,
    Object? profileImagePath = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthTime: freezed == birthTime
          ? _value.birthTime
          : birthTime // ignore: cast_nullable_to_non_nullable
              as String?,
      birthPlace: freezed == birthPlace
          ? _value.birthPlace
          : birthPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      concerns: null == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      profileImagePath: freezed == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingDataImplCopyWith<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  factory _$$OnboardingDataImplCopyWith(_$OnboardingDataImpl value,
          $Res Function(_$OnboardingDataImpl) then) =
      __$$OnboardingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? email,
      DateTime? birthDate,
      String? birthTime,
      String? birthPlace,
      String? gender,
      List<String> interests,
      List<String> concerns,
      String? profileImagePath});
}

/// @nodoc
class __$$OnboardingDataImplCopyWithImpl<$Res>
    extends _$OnboardingDataCopyWithImpl<$Res, _$OnboardingDataImpl>
    implements _$$OnboardingDataImplCopyWith<$Res> {
  __$$OnboardingDataImplCopyWithImpl(
      _$OnboardingDataImpl _value, $Res Function(_$OnboardingDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? birthDate = freezed,
    Object? birthTime = freezed,
    Object? birthPlace = freezed,
    Object? gender = freezed,
    Object? interests = null,
    Object? concerns = null,
    Object? profileImagePath = freezed,
  }) {
    return _then(_$OnboardingDataImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthTime: freezed == birthTime
          ? _value.birthTime
          : birthTime // ignore: cast_nullable_to_non_nullable
              as String?,
      birthPlace: freezed == birthPlace
          ? _value.birthPlace
          : birthPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      concerns: null == concerns
          ? _value._concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      profileImagePath: freezed == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingDataImpl implements _OnboardingData {
  const _$OnboardingDataImpl(
      {this.name,
      this.email,
      this.birthDate,
      this.birthTime,
      this.birthPlace,
      this.gender,
      final List<String> interests = const [],
      final List<String> concerns = const [],
      this.profileImagePath})
      : _interests = interests,
        _concerns = concerns;

  factory _$OnboardingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingDataImplFromJson(json);

  @override
  final String? name;
  @override
  final String? email;
  @override
  final DateTime? birthDate;
  @override
  final String? birthTime;
  @override
  final String? birthPlace;
  @override
  final String? gender;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  final List<String> _concerns;
  @override
  @JsonKey()
  List<String> get concerns {
    if (_concerns is EqualUnmodifiableListView) return _concerns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_concerns);
  }

  @override
  final String? profileImagePath;

  @override
  String toString() {
    return 'OnboardingData(name: $name, email: $email, birthDate: $birthDate, birthTime: $birthTime, birthPlace: $birthPlace, gender: $gender, interests: $interests, concerns: $concerns, profileImagePath: $profileImagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.birthTime, birthTime) ||
                other.birthTime == birthTime) &&
            (identical(other.birthPlace, birthPlace) ||
                other.birthPlace == birthPlace) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            const DeepCollectionEquality().equals(other._concerns, _concerns) &&
            (identical(other.profileImagePath, profileImagePath) ||
                other.profileImagePath == profileImagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      email,
      birthDate,
      birthTime,
      birthPlace,
      gender,
      const DeepCollectionEquality().hash(_interests),
      const DeepCollectionEquality().hash(_concerns),
      profileImagePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      __$$OnboardingDataImplCopyWithImpl<_$OnboardingDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingDataImplToJson(
      this,
    );
  }
}

abstract class _OnboardingData implements OnboardingData {
  const factory _OnboardingData(
      {final String? name,
      final String? email,
      final DateTime? birthDate,
      final String? birthTime,
      final String? birthPlace,
      final String? gender,
      final List<String> interests,
      final List<String> concerns,
      final String? profileImagePath}) = _$OnboardingDataImpl;

  factory _OnboardingData.fromJson(Map<String, dynamic> json) =
      _$OnboardingDataImpl.fromJson;

  @override
  String? get name;
  @override
  String? get email;
  @override
  DateTime? get birthDate;
  @override
  String? get birthTime;
  @override
  String? get birthPlace;
  @override
  String? get gender;
  @override
  List<String> get interests;
  @override
  List<String> get concerns;
  @override
  String? get profileImagePath;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OnboardingStep _$OnboardingStepFromJson(Map<String, dynamic> json) {
  return _OnboardingStep.fromJson(json);
}

/// @nodoc
mixin _$OnboardingStep {
  int get stepNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingStepCopyWith<OnboardingStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStepCopyWith<$Res> {
  factory $OnboardingStepCopyWith(
          OnboardingStep value, $Res Function(OnboardingStep) then) =
      _$OnboardingStepCopyWithImpl<$Res, OnboardingStep>;
  @useResult
  $Res call(
      {int stepNumber,
      String title,
      String subtitle,
      String? description,
      bool isCompleted,
      bool isRequired});
}

/// @nodoc
class _$OnboardingStepCopyWithImpl<$Res, $Val extends OnboardingStep>
    implements $OnboardingStepCopyWith<$Res> {
  _$OnboardingStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? isRequired = null,
  }) {
    return _then(_value.copyWith(
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingStepImplCopyWith<$Res>
    implements $OnboardingStepCopyWith<$Res> {
  factory _$$OnboardingStepImplCopyWith(_$OnboardingStepImpl value,
          $Res Function(_$OnboardingStepImpl) then) =
      __$$OnboardingStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int stepNumber,
      String title,
      String subtitle,
      String? description,
      bool isCompleted,
      bool isRequired});
}

/// @nodoc
class __$$OnboardingStepImplCopyWithImpl<$Res>
    extends _$OnboardingStepCopyWithImpl<$Res, _$OnboardingStepImpl>
    implements _$$OnboardingStepImplCopyWith<$Res> {
  __$$OnboardingStepImplCopyWithImpl(
      _$OnboardingStepImpl _value, $Res Function(_$OnboardingStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? isRequired = null,
  }) {
    return _then(_$OnboardingStepImpl(
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingStepImpl implements _OnboardingStep {
  const _$OnboardingStepImpl(
      {required this.stepNumber,
      required this.title,
      required this.subtitle,
      this.description,
      this.isCompleted = false,
      this.isRequired = false});

  factory _$OnboardingStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingStepImplFromJson(json);

  @override
  final int stepNumber;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isRequired;

  @override
  String toString() {
    return 'OnboardingStep(stepNumber: $stepNumber, title: $title, subtitle: $subtitle, description: $description, isCompleted: $isCompleted, isRequired: $isRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStepImpl &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stepNumber, title, subtitle,
      description, isCompleted, isRequired);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStepImplCopyWith<_$OnboardingStepImpl> get copyWith =>
      __$$OnboardingStepImplCopyWithImpl<_$OnboardingStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingStepImplToJson(
      this,
    );
  }
}

abstract class _OnboardingStep implements OnboardingStep {
  const factory _OnboardingStep(
      {required final int stepNumber,
      required final String title,
      required final String subtitle,
      final String? description,
      final bool isCompleted,
      final bool isRequired}) = _$OnboardingStepImpl;

  factory _OnboardingStep.fromJson(Map<String, dynamic> json) =
      _$OnboardingStepImpl.fromJson;

  @override
  int get stepNumber;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String? get description;
  @override
  bool get isCompleted;
  @override
  bool get isRequired;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingStepImplCopyWith<_$OnboardingStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
