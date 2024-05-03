import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:railgram/features/PnrNumber/screen/pnrdetailsscreen.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:railgram/features/community/provider/pnrprovider.dart';
import 'package:railgram/features/community/screens/communityprofile.dart';
import 'package:railgram/features/community/services/communityservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({
    super.key,
  });
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey _formkey = GlobalKey<FormState>();
  final GlobalVariable globalvariable = GlobalVariable();
  final PnrProvider _pnrProvider = PnrProvider();
  final CommunityServices _communityServices = CommunityServices();

  bool checkCommunityAvailabilty(
      BuildContext context, List<dynamic> communities) {
    var pnrdataprovider = Provider.of<PnrDataProvider>(context, listen: false);
    bool value = false;
    bool stop = false;
    int index = 0;

    while (stop != true) {
      for (var i in communities) {
        if (i["train_number"].toString() ==
            pnrdataprovider.pnrDataModel.trainNo.toString()) {
          value = true;
          stop = true;
        } else if (index == communities.length) {
          stop = true;
        }
        index++;
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    var communityprovider =
        Provider.of<CommunityProvider>(context, listen: false);
    var pnrprovider = Provider.of<PnrProvider>(context, listen: false);
    var pnrDatprovider = Provider.of<PnrDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Community'),
        leading: const Icon(FontAwesomeIcons.train),
        actions: [
          IconButton(
              onPressed: () {
                List<String> itemlist =
                    getSearchItems(communityprovider.allCommunities);
                showSearch(
                    context: context, delegate: CustomSearchDelegate(itemlist));
              },
              icon: const Icon(FontAwesomeIcons.magnifyingGlass))
        ],
      ),
      floatingActionButton:
          (context.watch<PnrDataProvider>().pnrDataModel.trainNo != '')
              ? null
              : FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PnrDetailsScreen(),
                    ));
                  },
                  label: const Row(
                    children: [Icon(Icons.not_interested), Text('Verify PNR')],
                  ),
                ),
      body: SafeArea(
        child: Column(
          children: [
            // InkWell(
            //   onTap: () {
            //     List<String> itemlist =
            //         getSearchItems(communityprovider.allCommunities);
            //     showSearch(
            //         context: context, delegate: CustomSearchDelegate(itemlist));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: const EdgeInsets.all(3),
            //       height: 50,
            //       child: Container(
            //         decoration: BoxDecoration(
            //             color: secondaryColor,
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.grey[400]!,
            //                   blurRadius: 15,
            //                   offset: const Offset(-5, 5))
            //             ],
            //             //border: Border.all(width: 0.1),
            //             borderRadius:
            //                 const BorderRadius.all(Radius.circular(10))),
            //         child: const TextField(
            //           decoration: InputDecoration(
            //               prefixIcon: Icon(Icons.search),
            //               enabled: false,
            //               hintText: 'train no....',
            //               border:
            //                   OutlineInputBorder(borderSide: BorderSide.none)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Can't find your train?"),
                TextButton(
                    onPressed: () async {
                      log('message');
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String? pnr = preferences.getString('PNRNUMBER');
                      log(pnr!);
                      if (pnr.isNotEmpty) {
                        log('pnr available');
                        log(pnrDatprovider.pnrDataModel.trainNo);
                        bool value = false;
                        value = (checkCommunityAvailabilty(
                            context, communityprovider.allCommunities));
                        if (value == false) {
                          _communityServices.addCommunity(
                              context, pnrDatprovider.pnrDataModel.trainNo);
                          _communityServices.getAllCommunities(context);

                          showSnackBar(
                              context, 'community will be added soon ');
                        } else {
                          showSnackBar(context, "community alredy available");
                        }
                      } else {
                        showSnackBar(context, 'verify your pnr to add train');
                      }
                      // if (pnrDatprovider.pnrDataModel.trainNo != '') {
                      //   bool value = false;

                      //   value = (checkCommunityAvailabilty(
                      //       context, communityprovider.allCommunities));
                      //   print(value);
                      //   if (value == false) {
                      //     _communityServices.addCommunity(
                      //         context, pnrDatprovider.pnrDataModel.trainNo);
                      //     _communityServices.getAllCommunities(context);

                      //     showSnackBar(
                      //         context, 'community will be added soon ');
                      //   } else {
                      //     showSnackBar(context, "community alredy available");
                      //   }
                      // } else {
                      //   showSnackBar(context, 'verify your pnr to add train');
                      // }
                    },
                    child: const Text('Add Your Train'))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:
                      context.watch<CommunityProvider>().allCommunities.length,
                  itemBuilder: (context, index) {
                    var rating = context
                        .watch<CommunityProvider>()
                        .allCommunities[index]['rating'];

                    print(rating);
                    return SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            print(index);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CommunityProfileScreen(
                                rating: rating == null
                                    ? "0.0"
                                    : context
                                        .watch<CommunityProvider>()
                                        .allCommunities[index]['rating']
                                        .toStringAsFixed(1),
                                index: index,
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400]!,
                                      blurRadius: 15,
                                      offset: const Offset(-5, 5))
                                ]),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.train_rounded,
                                  color: secondaryColor,
                                ),
                              ),
                              title: Text(context
                                  .watch<CommunityProvider>()
                                  .allCommunities[index]['train_name']),
                              subtitle: Text(context
                                  .watch<CommunityProvider>()
                                  .allCommunities[index]['train_number']
                                  .toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellowAccent,
                                  ),
                                  Text(rating == null
                                      ? "0.0"
                                      : context
                                          .watch<CommunityProvider>()
                                          .allCommunities[index]['rating']
                                          .toStringAsFixed(1))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchItems;
  CustomSearchDelegate(
    this.searchItems,
  );
  //List<String> searchItems = getSearchItems();
  // Demo list to show querying

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var items in searchItems) {
      if (items.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(items);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var rating =
            context.watch<CommunityProvider>().allCommunities[index]['rating'];
        var result = matchQuery[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CommunityProfileScreen(
                  rating: rating == null
                      ? "0.0"
                      : context
                          .watch<CommunityProvider>()
                          .allCommunities[index]['rating']
                          .toStringAsFixed(1),
                  index: index,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchItems) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var rating =
            context.watch<CommunityProvider>().allCommunities[index]['rating'];
        var result = matchQuery[index];
        return InkWell(
          onTap: () {
            String element = result.split('-').first;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CommunityProfileScreen(
                  rating: rating == null
                      ? "0.0"
                      : context
                          .watch<CommunityProvider>()
                          .allCommunities[index]['rating']
                          .toStringAsFixed(1),
                  index: findIndexofList(context, element),
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
