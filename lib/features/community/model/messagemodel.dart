// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String type;
  String message;
  String createdat;
  String sender;
  String userid;
  String profileurl;

  MessageModel(
      {required this.type,
      required this.message,
      required this.createdat,
      required this.sender,
      required this.userid,
      required this.profileurl});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      type: json["type"],
      message: json["message"],
      createdat: json["time"],
      sender: json["sender"],
      userid: json["userid"],
      profileurl: json["profileurl"]);

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "time": createdat,
        "sender": sender,
        "userid": userid,
        "profileurl": profileurl
      };
}
