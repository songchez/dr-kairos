import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@collection
class UserModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;

  String? name;
  String? email;
  DateTime? birthDate;
  String? birthTime;
  String? birthPlace;
  String? gender;
  
  // 프로필 이미지 경로 (관상 분석용)
  String? profileImagePath;
  
  // 사용자 설정
  @JsonKey(defaultValue: true)
  bool notificationsEnabled;
  
  @JsonKey(defaultValue: 'ko')
  String language;
  
  // 앱 사용 통계
  DateTime? firstLaunchDate;
  DateTime? lastActiveDate;
  @JsonKey(defaultValue: 0)
  int totalConversations;
  @JsonKey(defaultValue: 0)
  int completedQuests;

  UserModel({
    this.name,
    this.email,
    this.birthDate,
    this.birthTime,
    this.birthPlace,
    this.gender,
    this.profileImagePath,
    this.notificationsEnabled = true,
    this.language = 'ko',
    this.firstLaunchDate,
    this.lastActiveDate,
    this.totalConversations = 0,
    this.completedQuests = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}