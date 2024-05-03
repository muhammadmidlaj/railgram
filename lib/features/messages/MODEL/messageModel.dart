import 'dart:convert';

ChatroomMessageModel messageModelFromJson(String str) =>
    ChatroomMessageModel.fromJson(json.decode(str));

String messageModelToJson(ChatroomMessageModel data) =>
    json.encode(data.toJson());

class ChatroomMessageModel {
  String messageId;
  String userId;
  String username;
  String communityId;
  String createdat;
  String message;
  String messageType;
  String profileimgurl;

  ChatroomMessageModel({
    required this.messageId,
    required this.userId,
    required this.username,
    required this.communityId,
    required this.createdat,
    required this.message,
    required this.messageType,
    required this.profileimgurl,
  });

  factory ChatroomMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatroomMessageModel(
        messageId: json["message_id"] ?? 'id',
        userId: json["user_id"],
        username: json["username"],
        communityId: json["community_id"],
        createdat: json["createdat"],
        message: json["message"],
        messageType: json["messageType"],
        profileimgurl: json["profileimgurl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "user_id": userId,
        "username": username,
        "community_id": communityId,
        "createdat": createdat,
        "message": message,
        "messageType": messageType,
        "profileimgurl": profileimgurl,
      };
}
