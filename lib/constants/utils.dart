import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(text)));
}

void loadingSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          const CircularProgressIndicator(),
        ],
      ),
    ),
  );
}

Future<bool> sharedPreferenceCheck(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool checked = false;
  String? value = sharedPreferences.getString(key);

  if (value == null) {
    checked = false;
  } else {
    checked = true;
  }

  return checked;
}

int findIndexofList(BuildContext context, String element) {
  String element1 = element.trim();
  int index = Provider.of<CommunityProvider>(context, listen: false)
      .trainNumbers
      .indexOf(element1);
  return index;
}
