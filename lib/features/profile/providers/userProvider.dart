import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/features/profile/model/userprofilemodel.dart';

class UserProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  UserProfile _user = UserProfile(
      userid: null,
      username: '',
      firstname: '',
      lastname: '',
      profileimgurl: '',
      coverimgurl: '',
      phonenumber: '',
      email: '');
  UserProfile get user => _user;

  bool userPostFetched = false;

  List<dynamic> fetcheduserPost = [];

  void setUserdetails(String user) {
    Map<String, dynamic> map = jsonDecode(user);
    _user = UserProfile.fromJson(map['data'][0]);
    notifyListeners();
  }

  void setUserpost(String posts) {
    Map<String, dynamic> postmap = jsonDecode(posts);

    fetcheduserPost = postmap['data'][0];
    userPostFetched = true;

    notifyListeners();
  }

  void setUserFromModel(UserProfile user) {
    _user = user;
    notifyListeners();
  }
}
