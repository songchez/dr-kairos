import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../core/constants/sage_constants.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
@collection
class ConversationModel {
  Id id = Isar.autoIncrement;

  late String conversationId;
  late String userId;
  
  @Enumerated(EnumType.name)
  late SageType sageType;
  
  late String title;
  late DateTime createdAt;
  DateTime? updatedAt;
  
  @JsonKey(defaultValue: true)
  bool isActive;

  ConversationModel({
    required this.conversationId,
    required this.userId,
    required this.sageType,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => _$ConversationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}

@JsonSerializable()
@collection
class MessageModel {
  Id id = Isar.autoIncrement;

  late String messageId;
  late String conversationId;
  
  @JsonKey(defaultValue: false)
  bool isFromUser;
  
  late String content;
  late DateTime timestamp;
  
  // 현자의 응답에 대한 추가 메타데이터
  String? emotion;
  double? confidence;
  List<String>? suggestedActions;

  MessageModel({
    required this.messageId,
    required this.conversationId,
    required this.isFromUser,
    required this.content,
    required this.timestamp,
    this.emotion,
    this.confidence,
    this.suggestedActions,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}