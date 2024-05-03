import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/community/model/reviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  addReview(
      {required BuildContext context,
      required int rating,
      required String userid,
      required String trainno}) async {
    ReviewModelElement review =
        ReviewModelElement(rating: rating, userid: userid, trainno: trainno);
    print(trainno);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    // http.Response response = await http.post(
    //   Uri(),
    //   body: review.toJson(),
    //   headers: <String, String>{
    //     'Content-Type': 'application/x-www-form-urlencoded'
    //   },
    // );

    http.Response response1 = await http.post(
      Uri.parse('$api_url/railgram-api/review/addreview'),
      body: review.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    httpErrorHandle(
        response: response1,
        context: context,
        onSuccess: (() {
          showSnackBar(context, 'review added sucessfully');
        }));

    print(response1);
  }

  Future fetchCommunityReview(
      {required String trainno, required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var parameter = {
      "trainno": trainno,
    };
    Uri uri = Uri.parse('$api_url/railgram-api/review/getreview');
    uri = uri.replace(queryParameters: parameter);

    http.Response response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
    // Map<String, dynamic> map = jsonDecode(response.body);
    // fecthedList = map['data'];
    print(response.body);
    //var postprovider = Provider.of<PostProvider>(context, listen: false);
    //postprovider.setCommunityPosts(response.body);
  }
}
