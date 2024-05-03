
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/PnrNumber/screen/pnrdetailsscreen.dart';
import 'package:railgram/features/Report/widget/reportaproblemwidget.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/features/profile/screen/profilescreen.dart';
import 'package:railgram/features/profile/widgets/profileMenuwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenOptions extends StatelessWidget {
  const ProfileScreenOptions({super.key});

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: bgColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  //height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          print("dsfsdf");
                          // PostServices postServices = PostServices();
                          // postServices.fetchUserPost(
                          //     context, userprovider.user.userid.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage(userprovider.user.profileimgurl),
                          onBackgroundImageError: (exception, stackTrace) {
                            return;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userprovider.user.username,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            userprovider.user.email,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: iconColor),
                          )
                        ],
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     PostServices postServices = PostServices();
                      //     postServices.fetchUserPost(
                      //         context, userprovider.user.userid.toString());
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => const ProfileScreen(),
                      //     ));
                      //   },
                      //   child: const Text("View Profile"),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: secondaryColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileMenuWidget(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PnrDetailsScreen(),
                          ));
                        },
                        title: 'Pnr Details',
                        icon: FontAwesomeIcons.ticket,
                        color: greenColor,
                      ),

                      ProfileMenuWidget(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return const ReportProblemWidget();
                            },
                          );
                        },
                        title: 'Report',
                        icon: FontAwesomeIcons.flag,
                        color: iconColor,
                      ),
                      ProfileMenuWidget(
                        onTap: () async {
                          userprovider.fetcheduserPost.clear();
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();

                          await preferences.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        },
                        title: 'Logout',
                        icon: FontAwesomeIcons.rightFromBracket,
                        color: lightRedColor,
                      ),

                      //for testing
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }
}
