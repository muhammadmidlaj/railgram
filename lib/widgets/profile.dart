import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';

import '../features/profile/screen/editprofilescreen.dart';

class Profile extends StatelessWidget {
  String coverimgurl = '';
  String profileimgurl = '';
  final String username;
  final String date;

  Profile(
      {super.key,
      required this.coverimgurl,
      required this.profileimgurl,
      required this.username,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        Positioned.fill(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    image: DecorationImage(
                        onError: (exception, stackTrace) =>
                            const Color.fromARGB(0, 8, 148, 255),
                        fit: BoxFit.cover,
                        image: NetworkImage(coverimgurl))),
                height: 95,
              ),
              Container(
                height: 100,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(username),
                      subtitle: Text(date),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 40,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) =>
                  const Color.fromARGB(0, 8, 148, 255),
              backgroundImage: NetworkImage(profileimgurl),
              backgroundColor: Colors.lightBlue,
              radius: 46,
            ),
          ),
        ),
        Positioned(
          top: 140,
          right: 15,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  coverimgurl: context.watch<UserProvider>().user.coverimgurl,
                  firstname: context.watch<UserProvider>().user.firstname,
                  lastname: context.watch<UserProvider>().user.lastname,
                  phonenumber: context.watch<UserProvider>().user.phonenumber,
                  profileimgurl:
                      context.watch<UserProvider>().user.profileimgurl,
                  userid: context.watch<UserProvider>().user.userid.toString(),
                ),
              ));
            },
            child: const Row(
              children: [Text('Edit Profile'), Icon(Icons.edit)],
            ),
          ),
        )
      ]),
    );
  }
}
