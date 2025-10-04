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
  String? get id => throw _privateConstructorUsedError;
  String get questId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  SageType? get createdBySage => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  QuestStatus get status => throw _privateConstructorUsedError;
  QuestDifficulty get difficulty => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get targetCount => throw _privateConstructorUsedError;
  int get currentProgress => throw _privateConstructorUsedError;
  int get rewardPoints => throw _privateConstructorUsedError;
  List<String>? get rewardItems => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

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
      {String? id,
      String questId,
      String userId,
      SageType? createdBySage,
      String title,
      String description,
      QuestStatus status,
      QuestDifficulty difficulty,
      DateTime createdAt,
      DateTime? dueDate,
      DateTime? completedAt,
      int targetCount,
      int currentProgress,
      int rewardPoints,
      List<String>? rewardItems,
      String? category,
      List<String>? tags});
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
    Object? id = freezed,
    Object? questId = null,
    Object? userId = null,
    Object? createdBySage = freezed,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? difficulty = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? targetCount = null,
    Object? currentProgress = null,
    Object? rewardPoints = null,
    Object? rewardItems = freezed,
    Object? category = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      questId: null == questId
          ? _value.questId
          : questId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBySage: freezed == createdBySage
          ? _value.createdBySage
          : createdBySage // ignore: cast_nullable_to_non_nullable
              as SageType?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuestStatus,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestDifficulty,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      rewardPoints: null == rewardPoints
          ? _value.rewardPoints
          : rewardPoints // ignore: cast_nullable_to_non_nullable
              as int,
      rewardItems: freezed == rewardItems
          ? _value.rewardItems
          : rewardItems // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      {String? id,
      String questId,
      String userId,
      SageType? createdBySage,
      String title,
      String description,
      QuestStatus status,
      QuestDifficulty difficulty,
      DateTime createdAt,
      DateTime? dueDate,
      DateTime? completedAt,
      int targetCount,
      int currentProgress,
      int rewardPoints,
      List<String>? rewardItems,
      String? category,
      List<String>? tags});
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
    Object? id = freezed,
    Object? questId = null,
    Object? userId = null,
    Object? createdBySage = freezed,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? difficulty = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? targetCount = null,
    Object? currentProgress = null,
    Object? rewardPoints = null,
    Object? rewardItems = freezed,
    Object? category = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$QuestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      questId: null == questId
          ? _value.questId
          : questId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBySage: freezed == createdBySage
          ? _value.createdBySage
          : createdBySage // ignore: cast_nullable_to_non_nullable
              as SageType?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuestStatus,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestDifficulty,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      rewardPoints: null == rewardPoints
          ? _value.rewardPoints
          : rewardPoints // ignore: cast_nullable_to_non_nullable
              as int,
      rewardItems: freezed == rewardItems
          ? _value._rewardItems
          : rewardItems // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestModelImpl extends _QuestModel {
  const _$QuestModelImpl(
      {this.id,
      required this.questId,
      required this.userId,
      this.createdBySage,
      required this.title,
      required this.description,
      this.status = QuestStatus.pending,
      this.difficulty = QuestDifficulty.medium,
      required this.createdAt,
      this.dueDate,
      this.completedAt,
      this.targetCount = 1,
      this.currentProgress = 0,
      this.rewardPoints = 10,
      final List<String>? rewardItems,
      this.category,
      final List<String>? tags})
      : _rewardItems = rewardItems,
        _tags = tags,
        super._();

  factory _$QuestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String questId;
  @override
  final String userId;
  @override
  final SageType? createdBySage;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final QuestStatus status;
  @override
  @JsonKey()
  final QuestDifficulty difficulty;
  @override
  final DateTime createdAt;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final int targetCount;
  @override
  @JsonKey()
  final int currentProgress;
  @override
  @JsonKey()
  final int rewardPoints;
  final List<String>? _rewardItems;
  @override
  List<String>? get rewardItems {
    final value = _rewardItems;
    if (value == null) return null;
    if (_rewardItems is EqualUnmodifiableListView) return _rewardItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? category;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'QuestModel(id: $id, questId: $questId, userId: $userId, createdBySage: $createdBySage, title: $title, description: $description, status: $status, difficulty: $difficulty, createdAt: $createdAt, dueDate: $dueDate, completedAt: $completedAt, targetCount: $targetCount, currentProgress: $currentProgress, rewardPoints: $rewardPoints, rewardItems: $rewardItems, category: $category, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questId, questId) || other.questId == questId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdBySage, createdBySage) ||
                other.createdBySage == createdBySage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.rewardPoints, rewardPoints) ||
                other.rewardPoints == rewardPoints) &&
            const DeepCollectionEquality()
                .equals(other._rewardItems, _rewardItems) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      questId,
      userId,
      createdBySage,
      title,
      description,
      status,
      difficulty,
      createdAt,
      dueDate,
      completedAt,
      targetCount,
      currentProgress,
      rewardPoints,
      const DeepCollectionEquality().hash(_rewardItems),
      category,
      const DeepCollectionEquality().hash(_tags));

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

abstract class _QuestModel extends QuestModel {
  const factory _QuestModel(
      {final String? id,
      required final String questId,
      required final String userId,
      final SageType? createdBySage,
      required final String title,
      required final String description,
      final QuestStatus status,
      final QuestDifficulty difficulty,
      required final DateTime createdAt,
      final DateTime? dueDate,
      final DateTime? completedAt,
      final int targetCount,
      final int currentProgress,
      final int rewardPoints,
      final List<String>? rewardItems,
      final String? category,
      final List<String>? tags}) = _$QuestModelImpl;
  const _QuestModel._() : super._();

  factory _QuestModel.fromJson(Map<String, dynamic> json) =
      _$QuestModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get questId;
  @override
  String get userId;
  @override
  SageType? get createdBySage;
  @override
  String get title;
  @override
  String get description;
  @override
  QuestStatus get status;
  @override
  QuestDifficulty get difficulty;
  @override
  DateTime get createdAt;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get completedAt;
  @override
  int get targetCount;
  @override
  int get currentProgress;
  @override
  int get rewardPoints;
  @override
  List<String>? get rewardItems;
  @override
  String? get category;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$QuestModelImplCopyWith<_$QuestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
