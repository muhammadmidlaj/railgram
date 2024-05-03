
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';

import 'package:railgram/features/profile/screen/profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMenuDrawer extends StatelessWidget {
  const ProfileMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      backgroundColor: Colors.white,
      width: 200,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              userprovider.user.username.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            accountEmail: Text(
              userprovider.user.email.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) =>
                  const Color.fromARGB(0, 8, 148, 255),
              backgroundImage:
                  NetworkImage(userprovider.user.profileimgurl.toString()),
            ),
            decoration: const BoxDecoration(color: Colors.white),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: () {
              PostServices postServices = PostServices();
              postServices.fetchUserPost(
                  context, userprovider.user.userid.toString());
              //userProfileServices.getUserPosts(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
