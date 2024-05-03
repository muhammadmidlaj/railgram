import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  String postid;
  String type;
  String description;

  ReportModel({
    required this.postid,
    required this.type,
    required this.description,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        postid: json["postid"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "postid": postid,
        "type": type,
        "description": description,
      };
}
