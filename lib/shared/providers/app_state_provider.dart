import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state_provider.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isLoading,
    @Default(false) bool isFirstLaunch,
    @Default(false) bool isAuthenticated,
    String? currentUserId,
    String? errorMessage,
  }) = _AppState;
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setFirstLaunch(bool isFirst) {
    state = state.copyWith(isFirstLaunch: isFirst);
  }

  void setAuthenticated(bool authenticated, {String? userId}) {
    state = state.copyWith(
      isAuthenticated: authenticated,
      currentUserId: userId,
    );
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(),
);