import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/features/profile/widgets/profilefeed.dart';
import 'package:railgram/widgets/profile.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: primaryColor,
                  expandedHeight: 200,
                  floating: true,
                  pinned: true,
                  bottom: const TabBar(
                      indicatorColor: primaryColor,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "Posts",
                        ),
                      ]),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Profile(
                      coverimgurl: userprovider.coverimgurl.toString(),
                      date: userprovider.email,
                      profileimgurl: userprovider.profileimgurl.toString(),
                      username: userprovider.username.toString(),
                    ),
                  ),
                )
              ];
            },
            body: const TabBarView(children: [
              ProfileFeedView(),
            ])),
      ),
    );
  }
}
