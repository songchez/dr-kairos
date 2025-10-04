// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sage_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SageState {
  List<SageModel> get sages => throw _privateConstructorUsedError;
  SageModel? get selectedSage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SageStateCopyWith<SageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SageStateCopyWith<$Res> {
  factory $SageStateCopyWith(SageState value, $Res Function(SageState) then) =
      _$SageStateCopyWithImpl<$Res, SageState>;
  @useResult
  $Res call(
      {List<SageModel> sages,
      SageModel? selectedSage,
      bool isLoading,
      String? errorMessage});

  $SageModelCopyWith<$Res>? get selectedSage;
}

/// @nodoc
class _$SageStateCopyWithImpl<$Res, $Val extends SageState>
    implements $SageStateCopyWith<$Res> {
  _$SageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sages = null,
    Object? selectedSage = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      sages: null == sages
          ? _value.sages
          : sages // ignore: cast_nullable_to_non_nullable
              as List<SageModel>,
      selectedSage: freezed == selectedSage
          ? _value.selectedSage
          : selectedSage // ignore: cast_nullable_to_non_nullable
              as SageModel?,
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

  @override
  @pragma('vm:prefer-inline')
  $SageModelCopyWith<$Res>? get selectedSage {
    if (_value.selectedSage == null) {
      return null;
    }

    return $SageModelCopyWith<$Res>(_value.selectedSage!, (value) {
      return _then(_value.copyWith(selectedSage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SageStateImplCopyWith<$Res>
    implements $SageStateCopyWith<$Res> {
  factory _$$SageStateImplCopyWith(
          _$SageStateImpl value, $Res Function(_$SageStateImpl) then) =
      __$$SageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SageModel> sages,
      SageModel? selectedSage,
      bool isLoading,
      String? errorMessage});

  @override
  $SageModelCopyWith<$Res>? get selectedSage;
}

/// @nodoc
class __$$SageStateImplCopyWithImpl<$Res>
    extends _$SageStateCopyWithImpl<$Res, _$SageStateImpl>
    implements _$$SageStateImplCopyWith<$Res> {
  __$$SageStateImplCopyWithImpl(
      _$SageStateImpl _value, $Res Function(_$SageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sages = null,
    Object? selectedSage = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SageStateImpl(
      sages: null == sages
          ? _value._sages
          : sages // ignore: cast_nullable_to_non_nullable
              as List<SageModel>,
      selectedSage: freezed == selectedSage
          ? _value.selectedSage
          : selectedSage // ignore: cast_nullable_to_non_nullable
              as SageModel?,
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

class _$SageStateImpl implements _SageState {
  const _$SageStateImpl(
      {final List<SageModel> sages = const [],
      this.selectedSage,
      this.isLoading = false,
      this.errorMessage})
      : _sages = sages;

  final List<SageModel> _sages;
  @override
  @JsonKey()
  List<SageModel> get sages {
    if (_sages is EqualUnmodifiableListView) return _sages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sages);
  }

  @override
  final SageModel? selectedSage;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SageState(sages: $sages, selectedSage: $selectedSage, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SageStateImpl &&
            const DeepCollectionEquality().equals(other._sages, _sages) &&
            (identical(other.selectedSage, selectedSage) ||
                other.selectedSage == selectedSage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sages),
      selectedSage,
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SageStateImplCopyWith<_$SageStateImpl> get copyWith =>
      __$$SageStateImplCopyWithImpl<_$SageStateImpl>(this, _$identity);
}

abstract class _SageState implements SageState {
  const factory _SageState(
      {final List<SageModel> sages,
      final SageModel? selectedSage,
      final bool isLoading,
      final String? errorMessage}) = _$SageStateImpl;

  @override
  List<SageModel> get sages;
  @override
  SageModel? get selectedSage;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$SageStateImplCopyWith<_$SageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
