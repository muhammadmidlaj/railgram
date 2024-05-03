import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:railgram/features/PnrNumber/screen/pnrdetailsscreen.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:railgram/features/community/provider/pnrprovider.dart';
import 'package:railgram/features/posts/globalPost/screen/createpost.dart';
import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/widgets/feedpostview.dart';

// ignore: must_be_immutable
class CommunityPostFeed extends StatefulWidget {
  String communityId;
  String trainno;
  CommunityPostFeed(
      {super.key, required this.communityId, required this.trainno});

  @override
  State<CommunityPostFeed> createState() => _CommunityPostFeedState();
}

class _CommunityPostFeedState extends State<CommunityPostFeed> {
  TextEditingController controller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  GlobalVariable globalvariable = GlobalVariable();
  final PostServices _postservices = PostServices();

  @override
  void initState() {
    super.initState();

    _postservices.fetchCommunityPost(context, widget.trainno);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 0, left: 8, right: 8),
              child: InkWell(
                onTap: () async {
                  bool check = await sharedPreferenceCheck('PNRNUMBER');
                  if (check) {
                    PnrDataProvider pnrProvider =
                        Provider.of<PnrDataProvider>(context, listen: false);
                    CommunityProvider communityProvider =
                        Provider.of<CommunityProvider>(context, listen: false);
                    print(
                        "${communityProvider.allCommunities[int.parse(widget.communityId)]['train_number']}${pnrProvider.pnrDataModel.trainNo}");
                    if (pnrProvider.pnrDataModel.trainNo ==
                        communityProvider
                            .allCommunities[int.parse(widget.communityId)]
                                ['train_number']
                            .toString()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreatePostPage(
                            communityId: widget.communityId.toString()),
                      ));
                    } else {
                      showSnackBar(context, 'You cant post on this community');
                    }
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PnrDetailsScreen(),
                    ));
                  }
                },
                child: Container(
                  //constraints: BoxConstraints(maxHeight: 136, minHeight: 50),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 229, 223, 223),
                    //border: Border.all(width: 0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.edit_note),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Type Something')
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: (context
                      .watch<PostProvider>()
                      .fetchedCommunityPosts
                      .isEmpty)
                  ? const Center(child: Text('posts not available'))
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => FeedPostView(
                            title: context
                                .watch<PostProvider>()
                                .fetchedCommunityPosts[index]['post_title'],
                            content: context
                                .watch<PostProvider>()
                                .fetchedCommunityPosts[index]['post_content'],
                            type: 'type',
                            profileurl: 'fre',
                            //  context
                            //     .watch<PostProvider>()
                            //     .fetchedCommunityPosts[index]['profileimgurl'],
                            username: context
                                .watch<PostProvider>()
                                .fetchedCommunityPosts[index]['username'],
                            date: convertDateToDays(context
                                .watch<PostProvider>()
                                .fetchedCommunityPosts[index]['created_at']),
                            postid: context
                                .watch<PostProvider>()
                                .fetchedCommunityPosts[index]['postid'],
                            // communityid: widget.communityId,
                            imgurl: '',
                            index: index,
                          ),
                      separatorBuilder: (context, index) => Container(
                            height: 20,
                          ),
                      itemCount: context
                          .watch<PostProvider>()
                          .fetchedCommunityPosts
                          .length),
            ),
          ],
        ),
      ),
    );
  }
}
