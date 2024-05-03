import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railgram/features/Home/screens/homepage.dart';
import 'package:railgram/features/PnrNumber/services/pnrdataservices.dart';

import 'package:railgram/features/community/screens/communitylistpage.dart';
import 'package:railgram/features/community/services/pnrservices.dart';

import 'package:railgram/features/explore/screens/generalPostScreen.dart';
import 'package:railgram/features/profile/screen/profilescreenv2.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String api_url = 'http://43.204.148.127:3000';
//http://43.204.148.127:3000
//http://10.0.2.2:3000
//10.0.3.2
//http://10.0.3.2:3000
// http://192.168.96.141 :3000
bool isloading = false;

List<Widget> homescreenitems = [
  const HomeScreen(),
  const GeneralPostScreen(),
  CommunityScreen(),
  const ProfileScreenOptions(),
];

const primaryColor = Color(0xFF425ebd);
const primaryColorDark = Color(0xFF24396f);
//const secondaryColor = Color(0xFF2A2D3E);
//const bgColor = Color(0xFF212132);

const secondaryColor = Color(0xFFffffff);
const bgColor = Color(0xFFf2f8ff);
const darkgreenColor = Color(0xFF2c614f);
const greenColor = Color(0xFF5ed9b4);
const violetColor = Color(0xFF9594ff);
const lightBlueColor = Color(0xFF57c9e7);
const lightRedColor = Color(0xFFff7c7b);

const iconColor = Color(0xFF828bab);

//converts big string to small string
String smallSentence(String content) {
  if (content.length > 250) {
    return '${content.substring(0, 250)}....';
  } else {
    return content;
  }
}

DateTime convertDate(String date) {
  var dateTime = DateTime.parse(date);
  dateTime = dateTime.toLocal();
  return dateTime;
}

String convertDateToDays(String date) {
  int hours = 0;

  var datetime = convertDate(date);

  Duration duration = DateTime.now().difference(datetime);
  if (duration.inSeconds <= 60) {
    hours = duration.inSeconds;
    return "$hours Seconds ago";
  } else if (duration.inMinutes <= 60) {
    hours = duration.inMinutes;
    return "$hours Minutes ago";
  } else if (duration.inHours <= 24) {
    hours = duration.inHours;
    return "$hours Hours ago";
  } else if (duration.inDays <= 30) {
    hours = duration.inDays;
    return "$hours Days ago";
  } else if (duration.inDays <= 365) {
    hours = int.parse((duration.inDays / 30).toString().split(".").first);
    return "$hours Months ago";
  } else {
    hours = int.parse((duration.inDays / 365).toString().split(".").first);
    return "$hours Years ago";
  }
}

//format date to yyy-mm-dd format
String formatDate(String date) {
  DateTime newDate = DateTime.parse(date);
  var localDate = newDate.toLocal();
  var newFormat = DateFormat("yyyy-MM-dd");
  String updatedDate = newFormat.format(localDate);
  return updatedDate;
}

//get community search items
List<String> getSearchItems(List<dynamic> itemlist) {
  List<String> searchItems = [];
  print(itemlist);
  for (var items in itemlist) {
    var trainno = items['train_number'];
    var trainname = items['train_name'];
    String joined = "$trainno - $trainname";
    searchItems.add(joined.toString());
  }

  return searchItems;
}

class GlobalVariable {
  PnrServices pnrServices = PnrServices();
  PnrDataServices pnrDataServices = PnrDataServices();

  displayDialogBox(
      BuildContext context, TextEditingController controller, formkey) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('verify pnr number'),
          content: Form(
            key: formkey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.length != 10) {
                  return 'check your pnr number';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('PNR NUMBER'),
              ),
              controller: controller,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancel')),
            ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState.validate()) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    var userid = sharedPreferences.getInt('userid');

                    await pnrDataServices.getPnrDataFromApi(
                        context, controller.text, userid.toString());

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('verify')),
          ],
        );
      },
    );
  }

  showLoader(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Validating....")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => true, child: alert);
      },
    );
  }
}
