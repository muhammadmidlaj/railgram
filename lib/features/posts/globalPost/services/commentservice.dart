import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/posts/globalPost/provider/commentprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentServices {
  void addComment(
    BuildContext context,
    String comment,
    String postid,
    String userid,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      http.Response response = await http.post(
        Uri.parse('$api_url/api/comments/addcomment'),
        body: {
          "userid": userid,
          "comment": comment,
          "postid": postid,
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'posted');
          CommentServices commentServices = CommentServices();
          commentServices.fetchComment(context, postid);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void fetchComment(BuildContext context, String postid) async {
    try {
      print('timer working');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      http.Response response = await http.get(
        Uri.parse('$api_url/api/comments/viewcomment/$postid'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token'
        },
      );
      var commentprovider =
          Provider.of<CommentProvider>(context, listen: false);
      commentprovider.setComments(response.body);
    } catch (e) {}
  }
}
