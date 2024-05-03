
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfileServices {
  void getUserDetails(
    BuildContext context,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    int? userid = sharedPreferences.getInt('userid');

    if (token == null) print('no token ');

    http.Response response = await http.get(
        Uri.parse('$api_url/api/userprofile/$userid'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token'
        });

    var userprovider = Provider.of<UserProvider>(context, listen: false);

    userprovider.setUserdetails(response.body);
  }

  void getUserPosts(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt('userid');
    String? token = sharedPreferences.getString('token');
    print(token);

    if (userId == null) print('no userid');
    if (token == null) print('no token');

    http.Response response = await http.get(
        Uri.parse('$api_url/api/v1/post/getuserpost/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token'
        });

    var userprovider = Provider.of<UserProvider>(context, listen: false);
    print(response.body);
    userprovider.setUserpost(response.body);
  }
}
