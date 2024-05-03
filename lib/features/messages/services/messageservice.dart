import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/messages/MODEL/messageModel.dart';

class MessageService {
  void addMessagesToDB(String communityid, String userid,
      ChatroomMessageModel message, BuildContext context) async {
    var parameter = {"community_id": communityid, "user_id": userid};
    Uri uri = Uri.parse('$api_url/railgram-api/messages/addMessages');
    uri = uri.replace(queryParameters: parameter);
    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: message.toJson(),
    );

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        print(response.statusCode);
      },
    );
  }

  Future<List<ChatroomMessageModel>> getAllMessages({
    required BuildContext context,
    required String communityid,
  }) async {
    var parameter = {
      "community_id": communityid,
    };
    Uri uri = Uri.parse('$api_url/railgram-api/messages/getAllMessages');
    uri = uri.replace(queryParameters: parameter);
    http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    List<ChatroomMessageModel> oldChatList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      log(map['data'][0][0].toString());
      List<dynamic> newList = map['data'][0];
      for (var i in newList) {
        ChatroomMessageModel model = ChatroomMessageModel.fromJson(i);
        oldChatList.add(model);
      }

      return oldChatList;
    } else {
      return oldChatList;
    }
  }
}
