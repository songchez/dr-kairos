import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../models/sage_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/sage_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/config/app_config.dart';

abstract class SageService {
  Future<String> startConversation({
    required String sageId,
    required String userId,
    required String initialMessage,
  });

  Future<String> sendMessage({
    required String conversationId,
    required String message,
    required String sageId,
  });

  Future<Map<String, String>> getRoundtableAdvice({
    required String userId,
    required String question,
    List<SageType>? selectedSages,
  });

  Future<void> updateSageStatus({
    required String sageId,
    required bool isAvailable,
    String? mood,
  });

  Future<Map<String, dynamic>> getSageStats(String sageId);

  Future<List<String>> analyzeSagePreferences(String userId);
}

class ApiSageService implements SageService {
  final ApiClient _apiClient;

  ApiSageService(this._apiClient);

  @override
  Future<String> startConversation({
    required String sageId,
    required String userId,
    required String initialMessage,
  }) async {
    try {
      final response = await _apiClient.post(
        '/conversation/start',
        data: {
          'sage_id': sageId,
          'user_id': userId,
          'message': initialMessage,
        },
      );

      return response.data['conversation_id'] as String;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '대화를 시작할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<String> sendMessage({
    required String conversationId,
    required String message,
    required String sageId,
  }) async {
    try {
      final response = await _apiClient.post(
        '/conversation/message',
        data: {
          'conversation_id': conversationId,
          'message': message,
          'sage_id': sageId,
        },
      );

      return response.data['response'] as String;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '메시지를 전송할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<Map<String, String>> getRoundtableAdvice({
    required String userId,
    required String question,
    List<SageType>? selectedSages,
  }) async {
    try {
      final sageIds = selectedSages?.map((type) => type.name).toList() ??
          SageType.values.map((type) => type.name).toList();

      final response = await _apiClient.post(
        '/roundtable/advice',
        data: {
          'user_id': userId,
          'question': question,
          'sage_ids': sageIds,
        },
      );

      return Map<String, String>.from(response.data['advice']);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '통합 조언을 받을 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<void> updateSageStatus({
    required String sageId,
    required bool isAvailable,
    String? mood,
  }) async {
    try {
      await _apiClient.put(
        '/sage/$sageId/status',
        data: {
          'is_available': isAvailable,
          if (mood != null) 'mood': mood,
        },
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '현자 상태를 업데이트할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getSageStats(String sageId) async {
    try {
      final response = await _apiClient.get('/sage/$sageId/stats');
      return response.data as Map<String, dynamic>;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '현자 통계를 가져올 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<List<String>> analyzeSagePreferences(String userId) async {
    try {
      final response = await _apiClient.get('/user/$userId/sage-preferences');
      return List<String>.from(response.data['preferred_sages']);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '선호도 분석을 할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }
}

// 오프라인용 더미 서비스
class MockSageService implements SageService {

  @override
  Future<String> startConversation({
    required String sageId,
    required String userId,
    required String initialMessage,
  }) async {
    // 시뮬레이션을 위한 지연
    await Future.delayed(const Duration(milliseconds: 1500));
    
    final conversationId = 'conv_${DateTime.now().millisecondsSinceEpoch}';
    return conversationId;
  }

  @override
  Future<String> sendMessage({
    required String conversationId,
    required String message,
    required String sageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    
    final sage = SageFactory.getSageById(sageId);
    if (sage == null) throw Exception('현자를 찾을 수 없습니다');

    // 현자별 더미 응답 생성
    final responses = _getDummyResponses(sage.type, message);
    final randomIndex = DateTime.now().millisecond % responses.length;
    
    return responses[randomIndex];
  }

  @override
  Future<Map<String, String>> getRoundtableAdvice({
    required String userId,
    required String question,
    List<SageType>? selectedSages,
  }) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    
    final sages = selectedSages ?? SageType.values;
    final advice = <String, String>{};
    
    for (final sageType in sages) {
      final sage = SageFactory.getSageByType(sageType);
      if (sage != null) {
        final responses = _getDummyResponses(sageType, question);
        advice[sage.id] = responses.first;
      }
    }
    
    return advice;
  }

  @override
  Future<void> updateSageStatus({
    required String sageId,
    required bool isAvailable,
    String? mood,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock implementation - no actual update needed
  }

  @override
  Future<Map<String, dynamic>> getSageStats(String sageId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    return {
      'total_conversations': 42,
      'average_rating': 4.7,
      'total_advice_given': 156,
      'user_satisfaction': 0.89,
    };
  }

  @override
  Future<List<String>> analyzeSagePreferences(String userId) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // 더미 선호도 데이터
    return ['stella', 'dr_kairos', 'gaia'];
  }

  List<String> _getDummyResponses(SageType sageType, String message) {
    switch (sageType) {
      case SageType.stella:
        return [
          '별들이 당신의 고민을 들고 있어요. 이번 주는 변화의 에너지가 강하니 새로운 시작을 고려해보세요.',
          '금성의 영향으로 인간관계에서 좋은 변화가 있을 예정입니다. 마음을 열고 기다려보세요.',
          '당신의 별자리는 지금 성장의 시기를 맞고 있어요. 도전을 두려워하지 마세요.',
        ];
      case SageType.solon:
        return [
          '사주를 보니 올해는 큰 변화의 해입니다. 준비된 마음으로 기회를 잡으세요.',
          '현재 상황은 일시적입니다. 인내심을 갖고 때를 기다리면 좋은 결과가 있을 것입니다.',
          '당신의 타고난 기질을 잘 활용한다면 어려움을 극복할 수 있습니다.',
        ];
      case SageType.orion:
        return [
          '타로카드가 "변화"를 보여주고 있어요. 새로운 길이 열릴 징조입니다.',
          '직감을 믿으세요. 당신의 내면이 이미 답을 알고 있습니다.',
          '숨겨진 진실이 곧 드러날 것입니다. 마음의 준비를 하세요.',
        ];
      case SageType.drKairos:
        return [
          '이 상황을 객관적으로 분석해보면, 단계별 접근이 필요해 보입니다.',
          '인지적 재구성을 통해 문제를 다른 관점에서 바라보는 것이 도움이 될 것 같습니다.',
          '스트레스 관리 기법을 활용하여 감정을 안정시킨 후 결정하시기 바랍니다.',
        ];
      case SageType.gaia:
        return [
          '자연의 흐름에 순응하세요. 강요하려 하지 말고 자연스럽게 풀리도록 두세요.',
          '주변 환경의 기운이 당신에게 영향을 주고 있어요. 공간을 정리해보세요.',
          '뿌리가 깊어야 나무가 튼튼합니다. 기본기를 다시 점검해보세요.',
        ];
      case SageType.selena:
        return [
          '달의 주기에 따라 감정이 변화하고 있어요. 자연스러운 흐름입니다.',
          '무의식을 관통하는 직관을 통해 답을 주고 있습니다.',
          '달빛 아래에서 명상하며 내면의 목소리에 귀 기울여보세요.',
        ];
    }
  }
}

// 프로바이더
final sageServiceProvider = Provider<SageService>((ref) {
  if (AppConfig.useMockServices) {
    return MockSageService();
  } else {
    final apiClient = ref.watch(apiClientProvider);
    return ApiSageService(apiClient);
  }
});