
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/posts/globalPost/model/globalpostmodel.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/features/posts/globalPost/provider/globalpostprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../profile/providers/userProvider.dart';

class GlobalPostServices {
  List<dynamic> fecthedList = [];
  final cloudinary = CloudinaryPublic('drbqzoiks', 'ml_default');

// add post to db
  void addPost({
    required BuildContext context,
    required String title,
    required String content,
    required String type,
    required String imagePath,
  }) async {
    try {
      var userprovider = Provider.of<UserProvider>(context, listen: false);
      String imgurl = '';
      if (imagePath == '') {
        imgurl = '';
      } else {
        imgurl = (await uploadToCloud(imagePath: imagePath))!;
      }

      Post globalpost = Post(
        postid: null,
        postTitle: title,
        postContent: content,
        imageurl: imgurl,
        postType: type,
        userId: userprovider.user.userid.toString(),
      );

      http.Response response = await http.post(
        Uri.parse('$api_url/api/v1/post/createpost'),
        body: globalpost.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: (() {
            showSnackBar(context, 'post created sucessfully');
            fetchGlobalPost(context);
          }));
    } catch (e) {
      showSnackBar(context, 'error here ${e.toString()}');
    }
  }

//add image to cloudinary and get url
  Future<String?> uploadToCloud({
    required String imagePath,
  }) async {
    try {
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(imagePath, folder: "test"));

      return response.secureUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //fetchpost

  void fetchGlobalPost(
    BuildContext context,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    http.Response response = await http.get(
        Uri.parse('$api_url/api/v1/post/getpost'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        });

    // Map<String, dynamic> map = jsonDecode(response.body);
    // fecthedList = map['data'];

    var globalpostprovider =
        Provider.of<GlobalPostProvider>(context, listen: false);
    globalpostprovider.setglobalPost(response.body);
  }
}
