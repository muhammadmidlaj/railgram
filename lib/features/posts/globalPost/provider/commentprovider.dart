import 'dart:convert';

import 'package:flutter/cupertino.dart';

class CommentProvider extends ChangeNotifier {
  List<dynamic> fetchedComments = [];

  void setComments(String comments) {
    Map<String, dynamic> commentMap = jsonDecode(comments);
    fetchedComments = commentMap['data'];

    notifyListeners();
  }
}
