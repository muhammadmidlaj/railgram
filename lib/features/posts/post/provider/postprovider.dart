import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/features/posts/post/model/postmodel.dart';

class PostProvider extends ChangeNotifier {
  final Post _post = Post(
      postTitle: '',
      postContent: '',
      postImageurl: '',
      postType: '',
      personUid: '',
      communityUid: '');

  List<dynamic> fetchedCommunityPosts = [];
  List<dynamic> fetchedCommunityQuestions = [];
  List<dynamic> homefeedPosts = [];
  bool homePostFetched = false;

  setCommunityPosts(String posts) {
    Map<String, dynamic> map = jsonDecode(posts);
    fetchedCommunityPosts = map['data'][0];

    notifyListeners();
  }

  setCommunityQuestions(String posts) {
    Map<String, dynamic> map = jsonDecode(posts);
    fetchedCommunityQuestions = map['data'][0];

    notifyListeners();
  }

  void setHomeFeed(String posts) {
    Map<String, dynamic> postmap = jsonDecode(posts);
    homefeedPosts = postmap['data'][0];
    homePostFetched = true;
    print('post provider++++++++++++++++');
    print(homefeedPosts);

    notifyListeners();
  }
}
