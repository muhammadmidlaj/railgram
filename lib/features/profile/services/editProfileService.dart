
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/profile/model/userprofilemodel.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:http/http.dart' as http;
import 'package:railgram/features/profile/services/userprofileservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';

class ProfileEditService {
  final cloudinary = CloudinaryPublic('drbqzoiks', 'ml_default');

  void updateProfile({
    required BuildContext context,
    required String firstname,
    required String lastname,
    required String phoneno,
    required String profileimgpath,
    required String coverimgpath,
  }) async {
    try {
      String profileurl;
      String coverurl;
      bool isProfileUrl = Uri.parse(profileimgpath).isAbsolute;
      bool isCoverurl = Uri.parse(coverimgpath).isAbsolute;

      if (isProfileUrl) {
        profileurl = profileimgpath;
      } else {
        if (profileimgpath == '') {
          profileurl = '';
        } else {
          profileurl = await uploadToCloud(imagePath: profileimgpath);
        }
      }

      if (isCoverurl) {
        coverurl = coverimgpath;
      } else {
        if (coverimgpath == '') {
          coverurl = '';
        } else {
          coverurl = await uploadToCloud(imagePath: coverimgpath);
        }
      }

      var userprovider = Provider.of<UserProvider>(context, listen: false);
      var userid = userprovider.user.userid;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');

      UserProfile userProfile = UserProfile(
          userid: userprovider.user.userid,
          username: userprovider.user.username,
          firstname: firstname,
          lastname: lastname,
          profileimgurl: profileurl,
          coverimgurl: coverurl,
          phonenumber: phoneno,
          email: userprovider.user.email);

      http.Response response = await http.put(
          Uri.parse('$api_url/api/userprofile//updateuser/$userid'),
          body: userProfile.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'updated successfully');
          UserProfileServices userProfileServices = UserProfileServices();
          userProfileServices.getUserDetails(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<String> uploadToCloud({
    required String imagePath,
  }) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(imagePath, folder: "userprofile"));

      return response.secureUrl;
    } catch (e) {
      print(e);
    }
    return '';
  }
}
