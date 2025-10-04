// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestState {
  List<QuestModel> get quests => throw _privateConstructorUsedError;
  List<QuestModel> get activeQuests => throw _privateConstructorUsedError;
  List<QuestModel> get completedQuests => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestStateCopyWith<QuestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestStateCopyWith<$Res> {
  factory $QuestStateCopyWith(
          QuestState value, $Res Function(QuestState) then) =
      _$QuestStateCopyWithImpl<$Res, QuestState>;
  @useResult
  $Res call(
      {List<QuestModel> quests,
      List<QuestModel> activeQuests,
      List<QuestModel> completedQuests,
      int totalPoints,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$QuestStateCopyWithImpl<$Res, $Val extends QuestState>
    implements $QuestStateCopyWith<$Res> {
  _$QuestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quests = null,
    Object? activeQuests = null,
    Object? completedQuests = null,
    Object? totalPoints = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      quests: null == quests
          ? _value.quests
          : quests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      activeQuests: null == activeQuests
          ? _value.activeQuests
          : activeQuests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      completedQuests: null == completedQuests
          ? _value.completedQuests
          : completedQuests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestStateImplCopyWith<$Res>
    implements $QuestStateCopyWith<$Res> {
  factory _$$QuestStateImplCopyWith(
          _$QuestStateImpl value, $Res Function(_$QuestStateImpl) then) =
      __$$QuestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<QuestModel> quests,
      List<QuestModel> activeQuests,
      List<QuestModel> completedQuests,
      int totalPoints,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$QuestStateImplCopyWithImpl<$Res>
    extends _$QuestStateCopyWithImpl<$Res, _$QuestStateImpl>
    implements _$$QuestStateImplCopyWith<$Res> {
  __$$QuestStateImplCopyWithImpl(
      _$QuestStateImpl _value, $Res Function(_$QuestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quests = null,
    Object? activeQuests = null,
    Object? completedQuests = null,
    Object? totalPoints = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$QuestStateImpl(
      quests: null == quests
          ? _value._quests
          : quests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      activeQuests: null == activeQuests
          ? _value._activeQuests
          : activeQuests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      completedQuests: null == completedQuests
          ? _value._completedQuests
          : completedQuests // ignore: cast_nullable_to_non_nullable
              as List<QuestModel>,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QuestStateImpl implements _QuestState {
  const _$QuestStateImpl(
      {final List<QuestModel> quests = const [],
      final List<QuestModel> activeQuests = const [],
      final List<QuestModel> completedQuests = const [],
      this.totalPoints = 0,
      this.isLoading = false,
      this.errorMessage})
      : _quests = quests,
        _activeQuests = activeQuests,
        _completedQuests = completedQuests;

  final List<QuestModel> _quests;
  @override
  @JsonKey()
  List<QuestModel> get quests {
    if (_quests is EqualUnmodifiableListView) return _quests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quests);
  }

  final List<QuestModel> _activeQuests;
  @override
  @JsonKey()
  List<QuestModel> get activeQuests {
    if (_activeQuests is EqualUnmodifiableListView) return _activeQuests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeQuests);
  }

  final List<QuestModel> _completedQuests;
  @override
  @JsonKey()
  List<QuestModel> get completedQuests {
    if (_completedQuests is EqualUnmodifiableListView) return _completedQuests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedQuests);
  }

  @override
  @JsonKey()
  final int totalPoints;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'QuestState(quests: $quests, activeQuests: $activeQuests, completedQuests: $completedQuests, totalPoints: $totalPoints, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestStateImpl &&
            const DeepCollectionEquality().equals(other._quests, _quests) &&
            const DeepCollectionEquality()
                .equals(other._activeQuests, _activeQuests) &&
            const DeepCollectionEquality()
                .equals(other._completedQuests, _completedQuests) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_quests),
      const DeepCollectionEquality().hash(_activeQuests),
      const DeepCollectionEquality().hash(_completedQuests),
      totalPoints,
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestStateImplCopyWith<_$QuestStateImpl> get copyWith =>
      __$$QuestStateImplCopyWithImpl<_$QuestStateImpl>(this, _$identity);
}

abstract class _QuestState implements QuestState {
  const factory _QuestState(
      {final List<QuestModel> quests,
      final List<QuestModel> activeQuests,
      final List<QuestModel> completedQuests,
      final int totalPoints,
      final bool isLoading,
      final String? errorMessage}) = _$QuestStateImpl;

  @override
  List<QuestModel> get quests;
  @override
  List<QuestModel> get activeQuests;
  @override
  List<QuestModel> get completedQuests;
  @override
  int get totalPoints;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$QuestStateImplCopyWith<_$QuestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
