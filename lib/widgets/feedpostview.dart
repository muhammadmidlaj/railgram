import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/features/posts/postview.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/features/Report/widget/reportwidget.dart';

class FeedPostView extends StatelessWidget {
  final String postid;
  final String title;
  final String content;
  final String type;
  final String? imgurl;
  final String username;
  final String profileurl;
  final String date;
  final String? communityid;
  final int index;
  final String? screentype;

  FeedPostView(
      {super.key,
      required this.title,
      required this.content,
      this.imgurl,
      required this.type,
      required this.profileurl,
      required this.username,
      required this.date,
      required this.postid,
      this.communityid,
      required this.index,
      this.screentype});

  late final DateTime converteddate = convertDate(date);

  @override
  Widget build(BuildContext context) {
    PostServices postServices = PostServices();
    var userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostView(
            postid: postid,
            imgurl: imgurl,
            title: title,
            content: content,
            type: type,
            username: username,
            profileurl: profileurl,
            date: date,
            commentcount: context
                .watch<PostProvider>()
                .homefeedPosts[index]['comment_count']
                .toString(),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: secondaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    (communityid == null || communityid == '')
                        ? CircleAvatar(
                            onBackgroundImageError: (exception, stackTrace) =>
                                const Color.fromARGB(0, 8, 148, 255),
                            radius: 18,
                            backgroundImage: profileurl == ''
                                ? null
                                : NetworkImage(profileurl),
                          )
                        : Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.transparent, BlendMode.overlay),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(context
                                                .watch<CommunityProvider>()
                                                .allCommunities[
                                            findIndexofList(
                                                context, communityid!)]
                                        ['train_profileurl'])),
                                color: Colors.blue,
                                border: Border.all(width: 0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0))),
                            child: const Stack(
                              children: [
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: CircleAvatar(
                                //     radius: 13,
                                //     backgroundColor: Colors.white,
                                //     child: CircleAvatar(
                                //       onBackgroundImageError: (exception,
                                //               stackTrace) =>
                                //           const Color.fromARGB(0, 8, 148, 255),
                                //       radius: 12,
                                //       backgroundImage: profileurl == ''
                                //           ? null
                                //           : NetworkImage(profileurl),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (communityid == null || communityid == '')
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  //converteddate.toString().substring(0, 16),
                                  date,
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                          .watch<CommunityProvider>()
                                          .allCommunities[
                                      findIndexofList(
                                          context, communityid!)]['train_name'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'posted by $username',
                                        style: const TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Text(
                                          //converteddate.toString().substring(0, 16),
                                          date,
                                          style: const TextStyle(
                                            fontSize: 9,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 30,
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        if (screentype == "userprofile") {
                          return [
                            PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  print(postid);
                                  postServices.deletePost(context, postid);
                                  postServices.fetchUserPost(context,
                                      userProvider.user.userid.toString());
                                  postServices.fetchPostForHomeFeed(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.delete),
                                    Text('Delete')
                                  ],
                                )),
                            // PopupMenuItem 2
                          ];
                        } else {
                          return [
                            PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  log('message');
                                  showBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) => ReportWidget(
                                            index: index,
                                            postid: postid,
                                          ));
                                },
                                // row with 2 children
                                child: const Row(
                                  children: [
                                    Icon(Icons.report),
                                    Text("Report")
                                  ],
                                )),
                            // PopupMenuItem 2
                          ];
                        }
                      },
                    )
                  ],
                ),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  smallSentence(content),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              if (imgurl == '' || imgurl == null)
                const SizedBox(
                  height: 1,
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(imgurl!),
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: 30,
                    //constraints: BoxConstraints(maxWidth: 150),
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.comment,
                              size: 15,
                              color: iconColor,
                            )),
                        Text(
                          context
                              .watch<PostProvider>()
                              .homefeedPosts[index]['comment_count']
                              .toString(),
                          style: const TextStyle(color: iconColor),
                        ),
                        const Text("Comment", style: TextStyle(color: iconColor)),
                      ],
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
