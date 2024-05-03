import 'dart:convert';

class GlobalPost {
  GlobalPost({
    required this.error,
    required this.message,
    required this.posts,
  });

  bool error;
  String message;
  List<Post> posts;

  factory GlobalPost.fromRawJson(String str) =>
      GlobalPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalPost.fromJson(Map<String, dynamic> json) => GlobalPost(
        error: json["error"],
        message: json["message"],
        posts: List<Post>.from(json["Posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "Posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    required this.postid,
    required this.postTitle,
    required this.postContent,
    required this.imageurl,
    required this.postType,
    required this.userId,
  });
  int? postid;
  String postTitle;
  String postContent;
  String imageurl;
  String postType;
  String userId;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postid: json["postid"],
        postTitle: json["postTitle"],
        postContent: json["postContent"],
        imageurl: json["imageurl"],
        postType: json["postType"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "postTitle": postTitle,
        "postContent": postContent,
        "imageurl": imageurl,
        "postType": postType,
        "userId": userId,
      };
}
