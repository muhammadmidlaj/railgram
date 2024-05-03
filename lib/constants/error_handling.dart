import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/constants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();

      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['data'].toString());
      break;
    case 500:
      showSnackBar(context, response.body);
      break;
    default:
  }
}

void userLoginError({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  Map resMap = json.decode(response.body);
  switch (resMap['error']) {
    case true:
      showSnackBar(context, jsonDecode(response.body)['message']);

      break;
    case false:
      showSnackBar(context, jsonDecode(response.body)['message']);
      onSuccess();
      break;

    default:
      showSnackBar(context, response.body);
  }
}

void apiErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  Map resMap = json.decode(response.body);
  switch (resMap['error']) {
    case true:
      showSnackBar(context, jsonDecode(response.body)['message']);

      break;
    case false:
      showSnackBar(context, jsonDecode(response.body)['message']);
      onSuccess();
      break;

    default:
      showSnackBar(context, response.body);
  }
}

showSnackBarOnError({required BuildContext context, required String text}) {
  showSnackBar(context, text);
}
