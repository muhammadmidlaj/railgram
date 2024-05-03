import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/community/services/communityservices.dart';
import 'package:railgram/features/community/services/pnrservices.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  // GlobalPostServices globalPostServices = GlobalPostServices();
  final PostServices _postservices = PostServices();
  final PnrServices _pnrServices = PnrServices();
  final CommunityServices _communityservices = CommunityServices();

  @override
  void initState() {
    // _postservices.fetchPostForHomeFeed(context);
    Timer.periodic(const Duration(minutes: 2), (Timer timer) {
      // if (!_isRunning) {
      //   // cancel the timer
      //   timer.cancel();
      // }
      // globalPostServices.fetchGlobalPost(context);
      _postservices.fetchPostForHomeFeed(context);
    });
    _communityservices.getAllCommunities(context);
    _pnrServices.getVerifiedPnrData(context);
    _pnrServices.pnrExpireCheck(context);
    super.initState();

    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void onNavigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        children: homescreenitems,
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: onNavigationTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                color: (_page == 0) ? primaryColor : Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.globe,
                color: (_page == 1) ? primaryColor : Colors.black,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.train,
                color: (_page == 2) ? primaryColor : Colors.black,
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                color: (_page == 3) ? primaryColor : Colors.black,
              ),
              label: 'Profile',
            )
          ]),
    );
  }
}
