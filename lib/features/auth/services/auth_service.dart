import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/auth/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/profile/services/userprofileservices.dart';
import 'package:railgram/features/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(username: username, email: email, password: password);
      http.Response response = await http.post(
        Uri.parse('$api_url/api/v1/user/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () {
          showSnackBar(context, 'Account created Login with credentiols');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    http.Response res = await http.post(
      Uri.parse('$api_url/api/v1/user/login'),
      body: {'username': username, 'password': password},
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    userLoginError(
        response: res,
        context: context,
        onSuccess: (() async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Map newMap = jsonDecode(res.body);
          List user = newMap['data'];
          String token = newMap['token'];

          int userid = user[0]['userid'];
          String username = user[0]['username'];
          String email = user[0]['email'];

          sharedPreferences.setInt('userid', userid);
          sharedPreferences.setString('username', username);
          sharedPreferences.setString('email', email);
          sharedPreferences.setString('token', token);

          UserProfileServices profileservice = UserProfileServices();

          profileservice.getUserDetails(context);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SplashScreen(userid: userid),
          ));
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => const MobileScreenLayout(),
          // ));
        }));
  }
}
