import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/community/screens/reviewpage.dart';
import 'package:railgram/features/community/widgets/communitypostfeed.dart';
import 'package:railgram/features/community/widgets/communityquestionfeed.dart';

import '../provider/communityprovider.dart';
import '../widgets/communityprofilewidget.dart';

class CommunityProfileScreen extends StatefulWidget {
  final int index;
  final String rating;
  const CommunityProfileScreen(
      {super.key, required this.index, required this.rating});

  @override
  State<CommunityProfileScreen> createState() => _CommunityProfileScreenState();
}

class _CommunityProfileScreenState extends State<CommunityProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showAppbar = false;

  _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrolled) {
        _isScrolled = true;
        _showAppbar = true;
        setState(() {});
      }
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrolled) {
        _isScrolled = false;
        _showAppbar = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    print(widget.index);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            height: _showAppbar ? 100.0 : 0.0,
            duration: const Duration(
              milliseconds: 100,
            ),
            child: AppBar(
              backgroundColor: primaryColor,
              title: Text(context
                  .watch<CommunityProvider>()
                  .allCommunities[widget.index]['train_name']),
            ),
          ),
          Expanded(
            child: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          expandedHeight: 250,
                          floating: true,
                          pinned: true,
                          bottom: const TabBar(labelColor: Colors.black, tabs: [
                            Tab(
                              text: "Posts",
                            ),
                            Tab(
                              text: "Questions",
                            ),
                            Tab(text: "Reviews"),
                          ]),
                          flexibleSpace: FlexibleSpaceBar(
                            background: CommunityProfileWidget(
                              index: widget.index,
                              communityname: context
                                  .watch<CommunityProvider>()
                                  .allCommunities[widget.index]['train_name'],
                              profileurl: context
                                  .watch<CommunityProvider>()
                                  .allCommunities[widget.index]
                                      ['train_profileurl']
                                  .toString(),
                              rating: widget.rating,
                              trainnumber: context
                                  .watch<CommunityProvider>()
                                  .allCommunities[widget.index]['train_number']
                                  .toString(),
                            ),
                          ),
                        )
                      ];
                    },
                    body: TabBarView(children: [
                      CommunityPostFeed(
                          communityId: widget.index.toString(),
                          trainno: context
                              .watch<CommunityProvider>()
                              .allCommunities[widget.index]['train_number']
                              .toString()),
                      CommunityQuestionFeed(
                          communityId: widget.index.toString(),
                          trainno: context
                              .watch<CommunityProvider>()
                              .allCommunities[widget.index]['train_number']
                              .toString()),
                      ReviewPage(
                          rating: widget.rating,
                          index: widget.index.toString(),
                          trainno: context
                              .watch<CommunityProvider>()
                              .allCommunities[widget.index]['train_number']
                              .toString()),
                    ]))),
          ),
        ],
      ),
    );
  }
}
