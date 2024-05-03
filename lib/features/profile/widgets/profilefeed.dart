import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/widgets/feedpostview.dart';
import 'package:railgram/widgets/loaderlist.dart';

class ProfileFeedView extends StatefulWidget {
  const ProfileFeedView({super.key});

  @override
  State<ProfileFeedView> createState() => _ProfileFeedViewState();
}

class _ProfileFeedViewState extends State<ProfileFeedView> {
  @override
  void initState() {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    PostServices postServices = PostServices();
    postServices.fetchUserPost(context, userprovider.user.userid.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.fetcheduserPost);

    if (context.watch<UserProvider>().userPostFetched) {
      return ListView.separated(
          itemBuilder: (context, index) => FeedPostView(
                screentype: "userprofile",
                postid: context
                    .watch<UserProvider>()
                    .fetcheduserPost[index]['postid']
                    .toString(),
                title: context.watch<UserProvider>().fetcheduserPost[index]
                    ['post_title'],
                content: context.watch<UserProvider>().fetcheduserPost[index]
                    ['post_content'],
                type: context.watch<UserProvider>().fetcheduserPost[index]
                    ['post_type'],
                profileurl: context
                    .watch<UserProvider>()
                    .fetcheduserPost[index]['profileimgurl']
                    .toString(),
                username: context.watch<UserProvider>().fetcheduserPost[index]
                    ['username'],
                date: convertDateToDays(context
                    .watch<UserProvider>()
                    .fetcheduserPost[index]['created_at']),
                imgurl: context.watch<UserProvider>().fetcheduserPost[index]
                    ['post_imageurl'],
                index: index,
              ),
          separatorBuilder: (context, index) => const Divider(
                thickness: 5,
                color: Color.fromARGB(255, 243, 243, 243),
              ),
          itemCount: context.watch<UserProvider>().fetcheduserPost.length);
    } else {
      return loaderList();
    }
  }
}
