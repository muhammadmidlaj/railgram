import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.postTitle,
    required this.postContent,
    required this.postImageurl,
    required this.postType,
    required this.personUid,
    required this.communityUid,
  });

  String postTitle;
  String postContent;
  String postImageurl;
  String postType;
  String personUid;
  String? communityUid;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postTitle: json["post_title"],
        postContent: json["post_content"],
        postImageurl: json["post_imageurl"],
        postType: json["post_type"],
        personUid: json["person_uid"],
        communityUid: json["community_uid"],
      );

  Map<String, dynamic> toJson() => {
        "post_title": postTitle,
        "post_content": postContent,
        "post_imageurl": postImageurl,
        "post_type": postType,
        "person_uid": personUid,
        "community_uid": communityUid,
      };
}
