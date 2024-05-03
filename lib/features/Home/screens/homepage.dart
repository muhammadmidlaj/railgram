import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/PnrNumber/services/pnrdataservices.dart';

import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/widgets/customeappbar.dart';
import 'package:railgram/widgets/feedpostview.dart';
import 'package:railgram/widgets/loaderlist.dart';

import '../../profile/widgets/profilemenudrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isloading = true;
  final PostServices _postservices = PostServices();
  @override
  void initState() {
    PnrDataServices pnrDataServices = PnrDataServices();
    pnrDataServices.getPnrDataDetails(context);
    pnrDataServices.getPassengerDetails(context);
    _postservices.fetchPostForHomeFeed(context);
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     _isloading = false;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        endDrawer: const ProfileMenuDrawer(),
        appBar: const CustomeAppBar(profileImage: '', titile: 'Home Feed'),
        body: context.watch<PostProvider>().homePostFetched
            ? Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FeedPostView(
                            postid: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['postid']
                                .toString(),
                            username: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['username'],
                            date: convertDateToDays(context
                                    .watch<PostProvider>()
                                    .homefeedPosts[index]['created_at'])
                                .toString(),
                            profileurl: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['profileimgurl']
                                .toString(),
                            title: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['post_title'],
                            content: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['post_content'],
                            type: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['post_type'],
                            imgurl: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['post_imageurl'],
                            communityid: context
                                .watch<PostProvider>()
                                .homefeedPosts[index]['community_uid'],
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                              thickness: 5,
                              color: Color.fromARGB(255, 243, 243, 243),
                            ),
                        itemCount:
                            context.watch<PostProvider>().homefeedPosts.length),
                  ),
                ],
              )
            : loaderList());
  }
}
