import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:railgram/features/community/services/reviewservice.dart';
import 'package:railgram/features/community/widgets/ratingbarwidget.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';

class ReviewPage extends StatefulWidget {
  final String trainno;
  final String index;
  final String rating;
  const ReviewPage(
      {super.key,
      required this.trainno,
      required this.index,
      required this.rating});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late StreamController _reviewController;
  ReviewService reviewService = ReviewService();

  loadPost() async {
    reviewService
        .fetchCommunityReview(trainno: widget.trainno, context: context)
        .then((res) async {
      _reviewController.add(res);
      return res;
    });
  }

  Future _handleRefresh() async {
    reviewService
        .fetchCommunityReview(trainno: widget.trainno, context: context)
        .then((res) async {
      _reviewController.add(res);
      return null;
    });
  }

  @override
  void initState() {
    loadPost();
    _reviewController = StreamController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //GlobalVariable globalvariable = GlobalVariable();

    var userprovider = Provider.of<UserProvider>(context, listen: false);
    int rating = int.parse(widget.rating.split('.').first).toInt();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          StatefulBuilder(builder: (context, setState) {
            return Container(
              child: RatingBar(
                value: rating,
                onChanged: (index) {
                  setState(
                    () {
                      rating = index;
                    },
                  );
                },
                onSubmit: () async {
                  bool check = await sharedPreferenceCheck('PNRNUMBER');
                  if (check) {
                    PnrDataProvider pnrProvider =
                        Provider.of<PnrDataProvider>(context, listen: false);
                    CommunityProvider communityProvider =
                        Provider.of<CommunityProvider>(context, listen: false);
                    print(
                        "${communityProvider.allCommunities[int.parse(widget.index)]['train_number']}${pnrProvider.pnrDataModel.trainNo}");
                    if (pnrProvider.pnrDataModel.trainNo ==
                        communityProvider
                            .allCommunities[int.parse(widget.index)]
                                ['train_number']
                            .toString()) {
                      reviewService.addReview(
                          context: context,
                          rating: rating,
                          userid: userprovider.user.userid.toString(),
                          trainno: widget.trainno);
                      _handleRefresh();
                    } else {
                      showSnackBar(context,
                          'You dont have a valid pnr number to add review');
                    }
                  } else {}
                },
              ),
            );
          }),
          // Expanded(
          //   child: Container(
          //     child: ListView.separated(
          //         scrollDirection: Axis.vertical,
          //         shrinkWrap: true,
          //         itemBuilder: (context, index) {
          //           return Container(
          //               child: const ListTile(
          //             leading: CircleAvatar(),
          //             title: Text('username'),
          //             trailing: Text('4.0'),
          //           ));
          //         },
          //         separatorBuilder: (context, index) =>
          //             const SizedBox(height: 5),
          //         itemCount: 5),
          //   ),
          // )
          Expanded(
            child: Container(
                child: StreamBuilder(
              stream: _reviewController.stream,
              builder: (context, AsyncSnapshot snapshot) {
                print('Has error: ${snapshot.hasError}');
                print('Has data: ${snapshot.hasData}');
                print('Snapshot Data ${snapshot.data}');

                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  var review = snapshot.data['data'][0];
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(review);

                        return Container(
                            child: ListTile(
                          leading: CircleAvatar(
                            onBackgroundImageError: (exception, stackTrace) {
                              return;
                            },
                            backgroundImage: NetworkImage(
                                review[index]["profileimgurl"] ?? ""),
                          ),
                          title: Text(review[index]['username']),
                          trailing: Text(review[index]['rating'].toString()),
                        ));
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: review.length);
                }
              },
            )),
          )
        ],
      ),
    );
  }
}
