import 'dart:async';

import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/PnrNumber/services/pnrdataservices.dart';

import 'package:railgram/features/profile/services/userprofileservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final int? userid;
  final String? pnr;
  const SplashScreen({super.key, required this.userid, this.pnr});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // var userid = sharedPreferences.getInt('userid');

    // checkLogin();
    UserProfileServices profileservice = UserProfileServices();
    PnrDataServices pnrDataServices = PnrDataServices();
    profileservice.getUserDetails(context);

    pnrDataServices.pnrDataExpiryCheck(context);
    pnrDataServices.getPnrDataDetails(context);
    pnrDataServices.getPassengerDetails(context);
    pnrDataServices.pnrDataExpiryCheck(context);

    Timer(
        const Duration(seconds: 10),
        () => widget.userid == null
            ? Navigator.of(context).pushReplacementNamed('/login')
            : Navigator.of(context)
                .pushNamedAndRemoveUntil('/mobile', (route) => false));
  }

  Future<void> checkLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userid = sharedPreferences.getInt('userid');

    if (userid != null) {
      setState(() {
        //check = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashlogo.png'),
            const Text(
              'RailGram',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
