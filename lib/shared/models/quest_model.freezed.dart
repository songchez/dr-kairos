// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestModel _$QuestModelFromJson(Map<String, dynamic> json) {
  return _QuestModel.fromJson(json);
}

/// @nodoc
mixin _$QuestModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  QuestCategory get category => throw _privateConstructorUsedError;
  QuestDifficulty get difficulty => throw _privateConstructorUsedError;
  SageType get suggestedBy => throw _privateConstructorUsedError;
  int get experiencePoints => throw _privateConstructorUsedError;
  Duration get estimatedTime => throw _privateConstructorUsedError;
  List<String> get steps => throw _privateConstructorUsedError;
  List<String> get rewards => throw _privateConstructorUsedError;
  QuestStatus get status => throw _privateConstructorUsedError;
  List<String> get completedSteps => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get userNote => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestModelCopyWith<QuestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestModelCopyWith<$Res> {
  factory $QuestModelCopyWith(
          QuestModel value, $Res Function(QuestModel) then) =
      _$QuestModelCopyWithImpl<$Res, QuestModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      QuestCategory category,
      QuestDifficulty difficulty,
      SageType suggestedBy,
      int experiencePoints,
      Duration estimatedTime,
      List<String> steps,
      List<String> rewards,
      QuestStatus status,
      List<String> completedSteps,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? expiresAt,
      String? userNote,
      int progress});
}

/// @nodoc
class _$QuestModelCopyWithImpl<$Res, $Val extends QuestModel>
    implements $QuestModelCopyWith<$Res> {
  _$QuestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? difficulty = null,
    Object? suggestedBy = null,
    Object? experiencePoints = null,
    Object? estimatedTime = null,
    Object? steps = null,
    Object? rewards = null,
    Object? status = null,
    Object? completedSteps = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? userNote = freezed,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as QuestCategory,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestDifficulty,
      suggestedBy: null == suggestedBy
          ? _value.suggestedBy
          : suggestedBy // ignore: cast_nullable_to_non_nullable
              as SageType,
      experiencePoints: null == experiencePoints
          ? _value.experiencePoints
          : experiencePoints // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewards: null == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuestStatus,
      completedSteps: null == completedSteps
          ? _value.completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestModelImplCopyWith<$Res>
    implements $QuestModelCopyWith<$Res> {
  factory _$$QuestModelImplCopyWith(
          _$QuestModelImpl value, $Res Function(_$QuestModelImpl) then) =
      __$$QuestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      QuestCategory category,
      QuestDifficulty difficulty,
      SageType suggestedBy,
      int experiencePoints,
      Duration estimatedTime,
      List<String> steps,
      List<String> rewards,
      QuestStatus status,
      List<String> completedSteps,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? expiresAt,
      String? userNote,
      int progress});
}

/// @nodoc
class __$$QuestModelImplCopyWithImpl<$Res>
    extends _$QuestModelCopyWithImpl<$Res, _$QuestModelImpl>
    implements _$$QuestModelImplCopyWith<$Res> {
  __$$QuestModelImplCopyWithImpl(
      _$QuestModelImpl _value, $Res Function(_$QuestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? difficulty = null,
    Object? suggestedBy = null,
    Object? experiencePoints = null,
    Object? estimatedTime = null,
    Object? steps = null,
    Object? rewards = null,
    Object? status = null,
    Object? completedSteps = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? userNote = freezed,
    Object? progress = null,
  }) {
    return _then(_$QuestModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as QuestCategory,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestDifficulty,
      suggestedBy: null == suggestedBy
          ? _value.suggestedBy
          : suggestedBy // ignore: cast_nullable_to_non_nullable
              as SageType,
      experiencePoints: null == experiencePoints
          ? _value.experiencePoints
          : experiencePoints // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewards: null == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuestStatus,
      completedSteps: null == completedSteps
          ? _value._completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestModelImpl implements _QuestModel {
  const _$QuestModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.difficulty,
      required this.suggestedBy,
      required this.experiencePoints,
      required this.estimatedTime,
      required final List<String> steps,
      required final List<String> rewards,
      this.status = QuestStatus.available,
      final List<String> completedSteps = const [],
      this.startedAt,
      this.completedAt,
      this.expiresAt,
      this.userNote,
      this.progress = 0})
      : _steps = steps,
        _rewards = rewards,
        _completedSteps = completedSteps;

  factory _$QuestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final QuestCategory category;
  @override
  final QuestDifficulty difficulty;
  @override
  final SageType suggestedBy;
  @override
  final int experiencePoints;
  @override
  final Duration estimatedTime;
  final List<String> _steps;
  @override
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  final List<String> _rewards;
  @override
  List<String> get rewards {
    if (_rewards is EqualUnmodifiableListView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewards);
  }

  @override
  @JsonKey()
  final QuestStatus status;
  final List<String> _completedSteps;
  @override
  @JsonKey()
  List<String> get completedSteps {
    if (_completedSteps is EqualUnmodifiableListView) return _completedSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSteps);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? expiresAt;
  @override
  final String? userNote;
  @override
  @JsonKey()
  final int progress;

  @override
  String toString() {
    return 'QuestModel(id: $id, title: $title, description: $description, category: $category, difficulty: $difficulty, suggestedBy: $suggestedBy, experiencePoints: $experiencePoints, estimatedTime: $estimatedTime, steps: $steps, rewards: $rewards, status: $status, completedSteps: $completedSteps, startedAt: $startedAt, completedAt: $completedAt, expiresAt: $expiresAt, userNote: $userNote, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.suggestedBy, suggestedBy) ||
                other.suggestedBy == suggestedBy) &&
            (identical(other.experiencePoints, experiencePoints) ||
                other.experiencePoints == experiencePoints) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._completedSteps, _completedSteps) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.userNote, userNote) ||
                other.userNote == userNote) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      category,
      difficulty,
      suggestedBy,
      experiencePoints,
      estimatedTime,
      const DeepCollectionEquality().hash(_steps),
      const DeepCollectionEquality().hash(_rewards),
      status,
      const DeepCollectionEquality().hash(_completedSteps),
      startedAt,
      completedAt,
      expiresAt,
      userNote,
      progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestModelImplCopyWith<_$QuestModelImpl> get copyWith =>
      __$$QuestModelImplCopyWithImpl<_$QuestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestModelImplToJson(
      this,
    );
  }
}

abstract class _QuestModel implements QuestModel {
  const factory _QuestModel(
      {required final String id,
      required final String title,
      required final String description,
      required final QuestCategory category,
      required final QuestDifficulty difficulty,
      required final SageType suggestedBy,
      required final int experiencePoints,
      required final Duration estimatedTime,
      required final List<String> steps,
      required final List<String> rewards,
      final QuestStatus status,
      final List<String> completedSteps,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final DateTime? expiresAt,
      final String? userNote,
      final int progress}) = _$QuestModelImpl;

  factory _QuestModel.fromJson(Map<String, dynamic> json) =
      _$QuestModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  QuestCategory get category;
  @override
  QuestDifficulty get difficulty;
  @override
  SageType get suggestedBy;
  @override
  int get experiencePoints;
  @override
  Duration get estimatedTime;
  @override
  List<String> get steps;
  @override
  List<String> get rewards;
  @override
  QuestStatus get status;
  @override
  List<String> get completedSteps;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get expiresAt;
  @override
  String? get userNote;
  @override
  int get progress;
  @override
  @JsonKey(ignore: true)
  _$$QuestModelImplCopyWith<_$QuestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
