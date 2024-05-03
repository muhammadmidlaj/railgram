import 'dart:convert';

import 'package:flutter/cupertino.dart';

class CommunityProvider extends ChangeNotifier {
  List<dynamic> allCommunities = [];
  List<String> trainNumbers = [];
  void setCommunities(String communities) {
    Map<String, dynamic> communitymap = jsonDecode(communities);

    allCommunities = communitymap['data'];

    print(allCommunities);

    for (var i in allCommunities) {
      trainNumbers.add(i['train_number'].toString());
    }
    print(trainNumbers.indexOf('16348'));

    notifyListeners();
  }
}
