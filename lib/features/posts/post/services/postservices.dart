import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';

import 'package:railgram/features/posts/post/model/postmodel.dart';
import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostServices {
  List<dynamic> fecthedList = [];
  final cloudinary = CloudinaryPublic('drbqzoiks', 'ml_default');

// add post to db
  void addPost({
    required BuildContext context,
    required String title,
    required String content,
    required String type,
    required String imagePath,
    required String? communityId,
  }) async {
    try {
      var userprovider = Provider.of<UserProvider>(context, listen: false);
      String imgurl = '';
      if (imagePath == '') {
        imgurl = '';
      } else {
        imgurl = (await uploadToCloud(imagePath: imagePath))!;
      }

      Post post = Post(
        postTitle: title,
        postContent: content,
        postImageurl: imgurl,
        communityUid: communityId,
        personUid: userprovider.user.userid.toString(),
        postType: type,
      );

      http.Response response = await http.post(
        Uri.parse('$api_url/railgram-api/post/create-post'),
        body: post.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: (() {
            showSnackBar(context, 'post created sucessfully');
            fetchPost(context);
          }));
    } catch (e) {
      print(e);
      showSnackBar(context, 'error here ${e.toString()}');
    }
  }

//add image to cloudinary and get url
  Future<String?> uploadToCloud({
    required String imagePath,
  }) async {
    try {
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(imagePath, folder: "postimages"));

      return response.secureUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //fetchpost

  void fetchPost(
    BuildContext context,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    // var parameter = {"trainno":"16348","posttype":"Post"};
    // Uri uri = Uri.parse('$api_url/railgram-api/post/getPostbycommunity');
    // uri = uri.replace()
    http.Response response =
        await http.get(Uri.parse(''), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });

    // Map<String, dynamic> map = jsonDecode(response.body);
    // fecthedList = map['data'];

    // var globalpostprovider = Provider.of<PostProvider>(context, listen: false);
    // globalpostprovider.setglobalPost(response.body);
  }

  void fetchPostForHomeFeed(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    http.Response response = await http.get(
        Uri.parse('$api_url/railgram-api/post/getPostForHomeFeed'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        });

    print(response.body);
    var postprovider = Provider.of<PostProvider>(context, listen: false);
    postprovider.setHomeFeed(response.body);
  }

  void fetchCommunityPost(
    BuildContext context,
    String trainno,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var parameter = {"trainno": trainno, "posttype": "Post"};
    Uri uri = Uri.parse('$api_url/railgram-api/post/getPostbycommunity');
    uri = uri.replace(queryParameters: parameter);
    print(uri.query);
    http.Response response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });

    // Map<String, dynamic> map = jsonDecode(response.body);
    // fecthedList = map['data'];
    print(response.body);
    var postprovider = Provider.of<PostProvider>(context, listen: false);
    postprovider.setCommunityPosts(response.body);
  }

  void fetchCommunityQuestion(
    BuildContext context,
    String trainno,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var parameter = {"trainno": trainno, "posttype": "Question"};
    Uri uri = Uri.parse('$api_url/railgram-api/post/getPostbycommunity');
    uri = uri.replace(queryParameters: parameter);
    print(uri.query);
    http.Response response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });

    // Map<String, dynamic> map = jsonDecode(response.body);
    // fecthedList = map['data'];
    print(response.body);
    var postprovider = Provider.of<PostProvider>(context, listen: false);
    postprovider.setCommunityQuestions(response.body);
  }

  void fetchUserPost(BuildContext context, String userid) async {
    print("called");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    var params = {"userid": userid};
    Uri url = Uri.parse("$api_url/railgram-api/post/getUserPost");
    url = url.replace(queryParameters: params);
    http.Response response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    });

    // if (response.statusCode == 200) {
    //   print(jsonDecode(response.body));
    //   Map<String, dynamic> map = jsonDecode(response.body);
    //   List<dynamic> userpost = map['data'][0];

    //   //log(response.body);
    // }

    apiErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        var userprovider = Provider.of<UserProvider>(context, listen: false);

        userprovider.setUserpost(response.body);
      },
    );
  }

  void deletePost(BuildContext context, String postid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var parameter = {"postid": postid};
    Uri uri = Uri.parse('$api_url/railgram-api/post/deletePost');
    uri = uri.replace(queryParameters: parameter);
    http.Response response = await http.delete(uri, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, jsonDecode(response.body)['message']);
      },
    );
  }

  void reportPost(BuildContext context, String postid) {}
}
