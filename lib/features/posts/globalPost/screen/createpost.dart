import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';

import 'package:railgram/features/posts/globalPost/widgets/createglobalpost.dart';
import 'package:railgram/features/posts/globalPost/widgets/createglobalquestion.dart';

class CreatePostPage extends StatelessWidget {
  final String? communityId;
  const CreatePostPage({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              backgroundColor: primaryColor,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                  labelColor: secondaryColor,
                  labelPadding: EdgeInsets.all(4),
                  tabs: [
                    Tab(
                      height: 20,
                      text: 'Question',
                    ),
                    Tab(
                      height: 20,
                      text: 'Post',
                    ),
                  ]),
            ),
          ),
          body: Column(
            children: [
              (communityId == null)
                  ? const SizedBox()
                  : Container(
                    
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(context
                                .watch<CommunityProvider>()
                                .allCommunities[int.parse(communityId!)]
                                    ['train_profileurl']
                                .toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(context
                                    .watch<CommunityProvider>()
                                    .allCommunities[int.parse(communityId!)]
                                ['train_name']),
                          )
                        ],
                      )),
              Expanded(
                child: TabBarView(
                  children: [
                    CreateGlobalQuestion(
                        communityid: (communityId == null)
                            ? null
                            : context
                                .watch<CommunityProvider>()
                                .allCommunities[int.parse(communityId!)]
                                    ['train_number']
                                .toString()),
                    CreateGlobalPost(
                      communityid: (communityId == null)
                          ? null
                          : context
                              .watch<CommunityProvider>()
                              .allCommunities[int.parse(communityId!)]
                                  ['train_number']
                              .toString(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
