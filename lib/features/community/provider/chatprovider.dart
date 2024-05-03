import 'package:flutter/material.dart';

import 'package:railgram/features/messages/MODEL/messageModel.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatroomMessageModel> messageList = [];
  void setMessage(msg) {
    messageList.add(msg);
    notifyListeners();
  }

  void clearMsgList() {
    messageList = [];
    notifyListeners();
  }

  void setOldMessage(messagelist) {
    messageList = messagelist;
    notifyListeners();
  }
}
