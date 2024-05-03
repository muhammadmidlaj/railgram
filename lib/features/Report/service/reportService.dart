import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/Report/model/reportmodel.dart';

class ReportService {
  void addReport(String postid, String description, String type,
      BuildContext context) async {
    ReportModel reportModel =
        ReportModel(postid: postid, type: type, description: description);

    http.Response response =
        await http.post(Uri.parse("$api_url/railgram-api/report/addReport"),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: reportModel.toJson());

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, jsonDecode(response.body)['message'].toString());
          Navigator.pop(context);
        });
  }
}
