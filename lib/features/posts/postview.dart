import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/posts/globalPost/provider/commentprovider.dart';
import 'package:railgram/features/posts/globalPost/services/commentservice.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/widgets/commentcard.dart';

class PostView extends StatefulWidget {
  final String title;
  final String content;
  final String type;
  final String? imgurl;
  final String username;
  final String profileurl;
  final String date;
  final String postid;
  final String commentcount;
  const PostView(
      {super.key,
      required this.title,
      required this.content,
      required this.type,
      this.imgurl,
      required this.username,
      required this.profileurl,
      required this.date,
      required this.postid,
      required this.commentcount});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Timer? _timer;
  CommentServices commentService = CommentServices();
  final PostServices _postServices = PostServices();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _commenteditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    commentService.fetchComment(context, widget.postid.toString());
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      commentService.fetchComment(context, widget.postid.toString());
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: secondaryColor,
      //appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    onBackgroundImageError:
                                        (exception, stackTrace) =>
                                            const Color.fromARGB(0, 8, 148, 255),
                                    radius: 18,
                                    backgroundImage:
                                        NetworkImage(widget.profileurl),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.username,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          //converteddate.toString().substring(0, 16),
                                          widget.date,
                                          style: const TextStyle(
                                            fontSize: 9,
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
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                widget.content,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            (widget.imgurl == '' || widget.imgurl == null)
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(widget.imgurl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: 30,
                                      //constraints: BoxConstraints(maxWidth: 150),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.comment,
                                                size: 15,
                                                color: iconColor,
                                              )),
                                          Text(
                                            widget.commentcount,
                                            style: const TextStyle(
                                                color: iconColor),
                                          ),
                                          const Text("Comment",
                                              style:
                                                  TextStyle(color: iconColor))
                                        ],
                                      ),
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    )),
                  )
                ],
                body: const CommentsSection(),
                // body: ListView.separated(
                //     itemBuilder: (context, index) => Container(
                //           height: 20,
                //           color: Colors.blue,
                //         ),
                //     separatorBuilder: (context, index) => Divider(
                //           color: Colors.black,
                //         ),
                //     itemCount: 20),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                child: Row(
                  children: [
                    Expanded(
                        child: Form(
                      key: _formkey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your comment';
                          }
                          return null;
                        },
                        controller: _commenteditingController,
                        decoration: const InputDecoration(
                            hintText: 'enter your comment ... ',
                            border: InputBorder.none,
                            filled: true),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: IconButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              commentService.addComment(
                                  context,
                                  _commenteditingController.text,
                                  widget.postid.toString(),
                                  userprovider.user.userid!.toString());
                              _postServices.fetchPostForHomeFeed(context);
                            }
                          },
                          icon: const Icon(Icons.send_rounded)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.separated(
          itemBuilder: (context, index) => CommentCard(
                comment: context.watch<CommentProvider>().fetchedComments[index]
                    ['comment'],
                date: context.watch<CommentProvider>().fetchedComments[index]
                    ['created_date'],
                profileurl: context
                    .watch<CommentProvider>()
                    .fetchedComments[index]['profileimgurl']
                    .toString(),
                username: context
                    .watch<CommentProvider>()
                    .fetchedComments[index]['username'],
              ),
          separatorBuilder: (context, index) => const Divider(
                color: Colors.red,
              ),
          itemCount: context.watch<CommentProvider>().fetchedComments.length),
    );
  }
}
