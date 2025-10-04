import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/sage_constants.dart';

part 'quest_model.freezed.dart';
part 'quest_model.g.dart';

enum QuestStatus {
  pending,
  active,
  completed,
  expired,
}

enum QuestDifficulty {
  easy,
  medium,
  hard,
}

// Freezed 데이터 모델 (비즈니스 로직용)
@freezed
class QuestModel with _$QuestModel {
  const QuestModel._();
  
  const factory QuestModel({
    String? id,
    required String questId,
    required String userId,
    SageType? createdBySage,
    required String title,
    required String description,
    @Default(QuestStatus.pending) QuestStatus status,
    @Default(QuestDifficulty.medium) QuestDifficulty difficulty,
    required DateTime createdAt,
    DateTime? dueDate,
    DateTime? completedAt,
    @Default(1) int targetCount,
    @Default(0) int currentProgress,
    @Default(10) int rewardPoints,
    List<String>? rewardItems,
    String? category,
    List<String>? tags,
  }) = _QuestModel;

  // 퀘스트 완료 여부 확인
  bool get isCompleted => currentProgress >= targetCount;
  
  // 진행률 계산
  double get progressPercentage => targetCount > 0 ? (currentProgress / targetCount).clamp(0.0, 1.0) : 0.0;

  factory QuestModel.fromJson(Map<String, dynamic> json) => _$QuestModelFromJson(json);
}

// Isar 데이터베이스 엔티티 (데이터 저장용)
@collection
class QuestEntity {
  Id id = Isar.autoIncrement;

  late String questId;
  late String userId;
  
  @Enumerated(EnumType.name)
  SageType? createdBySage;
  
  late String title;
  late String description;
  
  @Enumerated(EnumType.name)
  QuestStatus status = QuestStatus.pending;
  
  @Enumerated(EnumType.name)
  QuestDifficulty difficulty = QuestDifficulty.medium;
  
  late DateTime createdAt;
  DateTime? dueDate;
  DateTime? completedAt;
  
  int targetCount = 1;
  int currentProgress = 0;
  
  int rewardPoints = 10;
  List<String>? rewardItems;
  
  String? category;
  List<String>? tags;

  // QuestModel로 변환
  QuestModel toModel() {
    return QuestModel(
      id: id.toString(),
      questId: questId,
      userId: userId,
      createdBySage: createdBySage,
      title: title,
      description: description,
      status: status,
      difficulty: difficulty,
      createdAt: createdAt,
      dueDate: dueDate,
      completedAt: completedAt,
      targetCount: targetCount,
      currentProgress: currentProgress,
      rewardPoints: rewardPoints,
      rewardItems: rewardItems,
      category: category,
      tags: tags,
    );
  }

  // QuestModel에서 변환
  static QuestEntity fromModel(QuestModel model) {
    final entity = QuestEntity()
      ..questId = model.questId
      ..userId = model.userId
      ..createdBySage = model.createdBySage
      ..title = model.title
      ..description = model.description
      ..status = model.status
      ..difficulty = model.difficulty
      ..createdAt = model.createdAt
      ..dueDate = model.dueDate
      ..completedAt = model.completedAt
      ..targetCount = model.targetCount
      ..currentProgress = model.currentProgress
      ..rewardPoints = model.rewardPoints
      ..rewardItems = model.rewardItems
      ..category = model.category
      ..tags = model.tags;

    if (model.id != null) {
      entity.id = int.parse(model.id!);
    }

    return entity;
  }
}