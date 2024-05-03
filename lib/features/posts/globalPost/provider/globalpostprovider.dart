import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/features/posts/globalPost/model/globalpostmodel.dart';

class GlobalPostProvider extends ChangeNotifier {
  final Post _posts = Post(
      postid: null,
      postTitle: '',
      postContent: '',
      imageurl: '',
      postType: '',
      userId: '');

  Post get post => _posts;
  List<dynamic> homefeedPosts = [];

  void setglobalPost(String posts) {
    Map<String, dynamic> postmap = jsonDecode(posts);
    homefeedPosts = postmap['data'];
    print(homefeedPosts[2]['createat'].toString());

    notifyListeners();
  }
}
