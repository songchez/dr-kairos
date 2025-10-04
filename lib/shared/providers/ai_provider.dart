import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/ai_service.dart';
import '../models/sage_model.dart';

final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});

class ConversationState {
  final List<String> messages;
  final bool isLoading;
  final String? error;

  const ConversationState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ConversationState copyWith({
    List<String>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ConversationNotifier extends StateNotifier<ConversationState> {
  final AIService _aiService;

  ConversationNotifier(this._aiService) : super(const ConversationState());

  void clearConversation() {
    state = const ConversationState();
  }

  Future<Stream<String>> sendMessage(String message, SageModel sage) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final conversationHistory = List<String>.from(state.messages);
      conversationHistory.add('사용자: $message');
      
      final responseStream = await _aiService.streamChatResponse(
        message,
        sage,
        conversationHistory,
      );
      
      state = state.copyWith(
        messages: conversationHistory,
        isLoading: false,
      );
      
      return responseStream;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '응답을 받아오는 중 오류가 발생했습니다: $e',
      );
      rethrow;
    }
  }

  void addResponseToHistory(String response, SageModel sage) {
    final updatedMessages = List<String>.from(state.messages);
    updatedMessages.add('${sage.displayName}: $response');
    
    state = state.copyWith(messages: updatedMessages);
  }
}

final conversationProvider = StateNotifierProvider<ConversationNotifier, ConversationState>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  return ConversationNotifier(aiService);
});