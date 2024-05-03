import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


List<dynamic> testing = [];

class CommunityServices {
  void getAllCommunities(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    http.Response response = await http.get(
        Uri.parse('$api_url/api/community/getAllCommunities'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        });

    var communityProvider =
        Provider.of<CommunityProvider>(context, listen: false);

    communityProvider.setCommunities(response.body);
    // Map<String, dynamic> postmap = jsonDecode(response.body);
    // testing = postmap['data'];
    // print(testing);
  }

  void addCommunity(BuildContext context, String trainno) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Uri url = Uri.parse("https://trains.p.rapidapi.com/");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          'X-RapidAPI-Key':
              'f7a31e736amsh9065cb47adbcb18p1331f5jsn653fa944d057',
          'X-RapidAPI-Host': 'trains.p.rapidapi.com'
        },
        body: jsonEncode({"search": trainno}));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> trainmap = jsonDecode(response.body);
      print(trainmap[0]["train_num"]);
      print(trainmap[0]["name"]);

      http.Response res = await http.post(
          Uri.parse("$api_url/api/community/createCommunity"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          },
          body: {
            "train_number": trainmap[0]["train_num"].toString(),
            "train_name": trainmap[0]["name"]
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, res.body);
        },
      );
    } else if (response.statusCode == 400) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}
