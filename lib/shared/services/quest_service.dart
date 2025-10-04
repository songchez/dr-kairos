import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import '../../data/models/quest_model.dart';
import '../../core/constants/sage_constants.dart';
import '../../core/network/api_client.dart';

abstract class QuestService {
  Future<List<QuestModel>> generateDailyQuests(String userId);
  Future<List<QuestModel>> generateWeeklyQuests(String userId);
  Future<List<QuestModel>> generatePersonalizedQuests(String userId, List<String> interests, List<String> concerns);
  Future<QuestModel> createCustomQuest(String userId, String title, String description);
  Future<void> updateQuestProgress(String questId, int progress);
  Future<void> completeQuest(String questId);
}

class ApiQuestService implements QuestService {
  final ApiClient _apiClient;

  ApiQuestService(this._apiClient);

  @override
  Future<List<QuestModel>> generateDailyQuests(String userId) async {
    try {
      final response = await _apiClient.post(
        '/quest/generate/daily',
        data: {'user_id': userId},
      );

      final questsJson = response.data['quests'] as List<dynamic>;
      return questsJson
          .map((json) => QuestModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '일일 퀘스트를 생성할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<List<QuestModel>> generateWeeklyQuests(String userId) async {
    try {
      final response = await _apiClient.post(
        '/quest/generate/weekly',
        data: {'user_id': userId},
      );

      final questsJson = response.data['quests'] as List<dynamic>;
      return questsJson
          .map((json) => QuestModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '주간 퀘스트를 생성할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<List<QuestModel>> generatePersonalizedQuests(
    String userId,
    List<String> interests,
    List<String> concerns,
  ) async {
    try {
      final response = await _apiClient.post(
        '/quest/generate/personalized',
        data: {
          'user_id': userId,
          'interests': interests,
          'concerns': concerns,
        },
      );

      final questsJson = response.data['quests'] as List<dynamic>;
      return questsJson
          .map((json) => QuestModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '맞춤형 퀘스트를 생성할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<QuestModel> createCustomQuest(
    String userId,
    String title,
    String description,
  ) async {
    try {
      final response = await _apiClient.post(
        '/quest/create',
        data: {
          'user_id': userId,
          'title': title,
          'description': description,
        },
      );

      return QuestModel.fromJson(response.data['quest'] as Map<String, dynamic>);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '커스텀 퀘스트를 생성할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<void> updateQuestProgress(String questId, int progress) async {
    try {
      await _apiClient.put(
        '/quest/$questId/progress',
        data: {'progress': progress},
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '퀘스트 진행률을 업데이트할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }

  @override
  Future<void> completeQuest(String questId) async {
    try {
      await _apiClient.put(
        '/quest/$questId/complete',
        data: {'completed_at': DateTime.now().toIso8601String()},
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: '퀘스트를 완료할 수 없습니다: $e',
        statusCode: null,
        type: ApiExceptionType.unknown,
      );
    }
  }
}

class MockQuestService implements QuestService {
  final _random = math.Random();

  @override
  Future<List<QuestModel>> generateDailyQuests(String userId) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    final now = DateTime.now();
    final questTemplates = _getDailyQuestTemplates();
    
    // 3-5개의 일일 퀘스트 생성
    final questCount = 3 + _random.nextInt(3);
    final selectedTemplates = questTemplates..shuffle();
    
    return List.generate(questCount, (index) {
      final template = selectedTemplates[index % selectedTemplates.length];
      return QuestModel(
        questId: 'daily_${now.millisecondsSinceEpoch}_$index',
        userId: userId,
        createdBySage: template['sage'] as SageType?,
        title: template['title'] as String,
        description: template['description'] as String,
        status: QuestStatus.pending,
        difficulty: template['difficulty'] as QuestDifficulty,
        createdAt: now,
        dueDate: now.add(const Duration(days: 1)),
        targetCount: template['targetCount'] as int,
        rewardPoints: template['rewardPoints'] as int,
        category: template['category'] as String,
        tags: List<String>.from(template['tags'] as List),
      );
    });
  }

  @override
  Future<List<QuestModel>> generateWeeklyQuests(String userId) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    
    final now = DateTime.now();
    final questTemplates = _getWeeklyQuestTemplates();
    
    // 2-3개의 주간 퀘스트 생성
    final questCount = 2 + _random.nextInt(2);
    final selectedTemplates = questTemplates..shuffle();
    
    return List.generate(questCount, (index) {
      final template = selectedTemplates[index % selectedTemplates.length];
      return QuestModel(
        questId: 'weekly_${now.millisecondsSinceEpoch}_$index',
        userId: userId,
        createdBySage: template['sage'] as SageType?,
        title: template['title'] as String,
        description: template['description'] as String,
        status: QuestStatus.pending,
        difficulty: template['difficulty'] as QuestDifficulty,
        createdAt: now,
        dueDate: now.add(const Duration(days: 7)),
        targetCount: template['targetCount'] as int,
        rewardPoints: template['rewardPoints'] as int,
        category: template['category'] as String,
        tags: List<String>.from(template['tags'] as List),
      );
    });
  }

  @override
  Future<List<QuestModel>> generatePersonalizedQuests(
    String userId, 
    List<String> interests, 
    List<String> concerns,
  ) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    
    final now = DateTime.now();
    final personalizedTemplates = _getPersonalizedQuestTemplates(interests, concerns);
    
    // 관심사와 고민에 맞는 퀘스트 2-4개 생성
    final questCount = 2 + _random.nextInt(3);
    
    return List.generate(questCount, (index) {
      final template = personalizedTemplates[index % personalizedTemplates.length];
      return QuestModel(
        questId: 'personalized_${now.millisecondsSinceEpoch}_$index',
        userId: userId,
        createdBySage: template['sage'] as SageType?,
        title: template['title'] as String,
        description: template['description'] as String,
        status: QuestStatus.pending,
        difficulty: template['difficulty'] as QuestDifficulty,
        createdAt: now,
        dueDate: now.add(Duration(days: template['duration'] as int)),
        targetCount: template['targetCount'] as int,
        rewardPoints: template['rewardPoints'] as int,
        category: template['category'] as String,
        tags: List<String>.from(template['tags'] as List),
      );
    });
  }

  @override
  Future<QuestModel> createCustomQuest(String userId, String title, String description) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final now = DateTime.now();
    
    return QuestModel(
      questId: 'custom_${now.millisecondsSinceEpoch}',
      userId: userId,
      title: title,
      description: description,
      status: QuestStatus.pending,
      difficulty: QuestDifficulty.medium,
      createdAt: now,
      targetCount: 1,
      rewardPoints: 15,
      category: '개인 목표',
      tags: ['사용자 생성', '맞춤형'],
    );
  }

  List<Map<String, dynamic>> _getDailyQuestTemplates() {
    return [
      {
        'sage': SageType.drKairos,
        'title': '3분 명상하기',
        'description': '마음을 차분히 하고 3분간 명상을 해보세요.',
        'difficulty': QuestDifficulty.easy,
        'targetCount': 1,
        'rewardPoints': 10,
        'category': '마음챙김',
        'tags': ['명상', '휴식', '평정심'],
      },
      {
        'sage': SageType.gaia,
        'title': '자연 속 산책',
        'description': '15분 이상 자연 속에서 산책하며 기운을 충전하세요.',
        'difficulty': QuestDifficulty.easy,
        'targetCount': 1,
        'rewardPoints': 15,
        'category': '건강',
        'tags': ['운동', '자연', '힐링'],
      },
      {
        'sage': SageType.stella,
        'title': '감사 일기 쓰기',
        'description': '오늘 감사한 일 3가지를 적어보세요.',
        'difficulty': QuestDifficulty.easy,
        'targetCount': 3,
        'rewardPoints': 12,
        'category': '성찰',
        'tags': ['감사', '일기', '긍정'],
      },
      {
        'sage': SageType.solon,
        'title': '하루 계획 세우기',
        'description': '내일의 중요한 일 3가지를 미리 계획해보세요.',
        'difficulty': QuestDifficulty.easy,
        'targetCount': 3,
        'rewardPoints': 10,
        'category': '계획',
        'tags': ['계획', '준비', '효율성'],
      },
      {
        'sage': SageType.orion,
        'title': '직감 기록하기',
        'description': '오늘 느낀 직감이나 영감을 기록해보세요.',
        'difficulty': QuestDifficulty.medium,
        'targetCount': 1,
        'rewardPoints': 15,
        'category': '직감',
        'tags': ['직감', '영감', '창의성'],
      },
      {
        'sage': SageType.selena,
        'title': '달의 주기 확인',
        'description': '현재 달의 주기를 확인하고 기분 변화를 관찰해보세요.',
        'difficulty': QuestDifficulty.medium,
        'targetCount': 1,
        'rewardPoints': 12,
        'category': '달력술',
        'tags': ['달', '주기', '관찰'],
      },
    ];
  }

  List<Map<String, dynamic>> _getWeeklyQuestTemplates() {
    return [
      {
        'sage': SageType.drKairos,
        'title': '스트레스 관리 실천',
        'description': '일주일 동안 매일 스트레스 해소법을 실천해보세요.',
        'difficulty': QuestDifficulty.medium,
        'targetCount': 7,
        'rewardPoints': 50,
        'category': '건강',
        'tags': ['스트레스', '관리', '지속성'],
      },
      {
        'sage': SageType.stella,
        'title': '관계 개선 노력',
        'description': '중요한 사람과의 관계를 개선하기 위한 행동을 해보세요.',
        'difficulty': QuestDifficulty.hard,
        'targetCount': 3,
        'rewardPoints': 60,
        'category': '인간관계',
        'tags': ['관계', '소통', '화해'],
      },
      {
        'sage': SageType.gaia,
        'title': '생활 공간 정리',
        'description': '일주일에 걸쳐 생활 공간을 체계적으로 정리해보세요.',
        'difficulty': QuestDifficulty.medium,
        'targetCount': 5,
        'rewardPoints': 45,
        'category': '환경',
        'tags': ['정리', '공간', '에너지'],
      },
    ];
  }

  List<Map<String, dynamic>> _getPersonalizedQuestTemplates(
    List<String> interests, 
    List<String> concerns,
  ) {
    final templates = <Map<String, dynamic>>[];

    // 관심사 기반 퀘스트
    for (final interest in interests) {
      switch (interest) {
        case '사랑과 인간관계':
          templates.add({
            'sage': SageType.stella,
            'title': '사랑의 언어 실천',
            'description': '상대방이 좋아하는 사랑의 표현 방식을 찾아 실천해보세요.',
            'difficulty': QuestDifficulty.medium,
            'targetCount': 3,
            'rewardPoints': 25,
            'category': '사랑',
            'tags': ['사랑', '표현', '이해'],
            'duration': 3,
          });
          break;
        case '직업과 진로':
          templates.add({
            'sage': SageType.solon,
            'title': '커리어 로드맵 작성',
            'description': '향후 5년간의 커리어 계획을 구체적으로 세워보세요.',
            'difficulty': QuestDifficulty.hard,
            'targetCount': 1,
            'rewardPoints': 40,
            'category': '진로',
            'tags': ['커리어', '계획', '목표'],
            'duration': 7,
          });
          break;
        case '자기계발':
          templates.add({
            'sage': SageType.selena,
            'title': '여성성 회복 프로젝트',
            'description': '내면의 여성성을 발견하고 발전시키는 7일간의 여정을 시작하세요.',
            'difficulty': QuestDifficulty.medium,
            'targetCount': 7,
            'rewardPoints': 35,
            'category': '자아발견',
            'tags': ['여성성', '직관', '내면'],
            'duration': 7,
          });
          break;
      }
    }

    // 고민 기반 퀘스트
    for (final concern in concerns) {
      switch (concern) {
        case '인간관계 갈등':
          templates.add({
            'sage': SageType.drKairos,
            'title': '갈등 해결 대화',
            'description': '갈등이 있는 사람과 진솔한 대화를 나누어보세요.',
            'difficulty': QuestDifficulty.hard,
            'targetCount': 1,
            'rewardPoints': 50,
            'category': '관계 회복',
            'tags': ['갈등', '대화', '해결'],
            'duration': 5,
          });
          break;
        case '자신감 부족':
          templates.add({
            'sage': SageType.stella,
            'title': '자신감 회복 활동',
            'description': '자신감을 높일 수 있는 작은 성취를 매일 만들어보세요.',
            'difficulty': QuestDifficulty.medium,
            'targetCount': 5,
            'rewardPoints': 30,
            'category': '자신감',
            'tags': ['자신감', '성취', '긍정'],
            'duration': 5,
          });
          break;
        case '미래에 대한 불안':
          templates.add({
            'sage': SageType.selena,
            'title': '마음 정화 일지',
            'description': '달의 리듬에 맞춰 마음을 정화하고 감정을 안정시키는 일지를 써보세요.',
            'difficulty': QuestDifficulty.medium,
            'targetCount': 7,
            'rewardPoints': 35,
            'category': '마음 치유',
            'tags': ['정화', '치유', '안정'],
            'duration': 7,
          });
          break;
      }
    }

    return templates.isNotEmpty ? templates : _getDailyQuestTemplates();
  }

  @override
  Future<void> updateQuestProgress(String questId, int progress) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock implementation - no actual update needed
  }

  @override
  Future<void> completeQuest(String questId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Mock implementation - no actual completion needed
  }
}