import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/quest_model.dart';

class DatabaseService {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) return _isar!;
    
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        UserModelSchema,
        ConversationModelSchema,
        MessageModelSchema,
        QuestEntitySchema,
      ],
      directory: dir.path,
      name: 'kairos_sages_db',
    );
    
    return _isar!;
  }

  // User operations
  static Future<UserModel?> getUser(String userId) async {
    final isar = await instance;
    return await isar.userModels.filter().userIdEqualTo(userId).findFirst();
  }

  static Future<void> saveUser(UserModel user) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.userModels.put(user);
    });
  }

  static Future<void> deleteUser(String userId) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.userModels.filter().userIdEqualTo(userId).deleteAll();
    });
  }

  // Conversation operations
  static Future<List<ConversationModel>> getConversations(String userId) async {
    final isar = await instance;
    return await isar.conversationModels
        .filter()
        .userIdEqualTo(userId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  static Future<ConversationModel?> getConversation(String conversationId) async {
    final isar = await instance;
    return await isar.conversationModels
        .filter()
        .conversationIdEqualTo(conversationId)
        .findFirst();
  }

  static Future<void> saveConversation(ConversationModel conversation) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.conversationModels.put(conversation);
    });
  }

  // Message operations
  static Future<List<MessageModel>> getMessages(String conversationId) async {
    final isar = await instance;
    return await isar.messageModels
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByTimestamp()
        .findAll();
  }

  static Future<void> saveMessage(MessageModel message) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.messageModels.put(message);
    });
  }

  // Quest operations
  static Future<List<QuestModel>> getQuests(String userId) async {
    final isar = await instance;
    final entities = await isar.questEntitys
        .filter()
        .userIdEqualTo(userId)
        .sortByCreatedAtDesc()
        .findAll();
    return entities.map((e) => e.toModel()).toList();
  }

  static Future<List<QuestModel>> getActiveQuests(String userId) async {
    final isar = await instance;
    final entities = await isar.questEntitys
        .filter()
        .userIdEqualTo(userId)
        .statusEqualTo(QuestStatus.active)
        .sortByCreatedAtDesc()
        .findAll();
    return entities.map((e) => e.toModel()).toList();
  }

  static Future<void> saveQuest(QuestModel quest) async {
    final isar = await instance;
    final entity = QuestEntity.fromModel(quest);
    await isar.writeTxn(() async {
      await isar.questEntitys.put(entity);
    });
  }

  static Future<void> updateQuestProgress(String questId, int progress) async {
    final isar = await instance;
    await isar.writeTxn(() async {
      final entity = await isar.questEntitys
          .filter()
          .questIdEqualTo(questId)
          .findFirst();
      
      if (entity != null) {
        entity.currentProgress = progress;
        final model = entity.toModel();
        if (model.isCompleted && entity.status != QuestStatus.completed) {
          entity.status = QuestStatus.completed;
          entity.completedAt = DateTime.now();
        }
        await isar.questEntitys.put(entity);
      }
    });
  }

  // Clear all data
  static Future<void> clearAllData() async {
    final isar = await instance;
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  // Close database
  static Future<void> close() async {
    if (_isar != null) {
      await _isar!.close();
      _isar = null;
    }
  }
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});