import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/explore/screens/generalPostScreen.dart';
import 'package:railgram/features/explore/screens/questionListScreen.dart';
import 'package:railgram/features/posts/globalPost/services/createpostservices.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  final GlobalPostServices globalpost = GlobalPostServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            title: const Text('Explore'),
            backgroundColor: primaryColor,
            flexibleSpace: const Column(
              children: [
                TabBar(
                  indicatorColor: secondaryColor,
                  labelColor: secondaryColor,
                  tabs: [
                    Tab(
                      text: "General",
                    ),
                    Tab(
                      text: 'Question',
                    )
                  ],
                ),
              ],
            ),
          ),
          body: const TabBarView(
              children: [GeneralPostScreen(), QuestionListScreen()]),
        ),
      ),
    );
  }
}
