import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:railgram/features/PnrNumber/services/pnrdataservices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PnrDetailsScreen extends StatefulWidget {
  const PnrDetailsScreen({super.key});

  @override
  State<PnrDetailsScreen> createState() => _PnrDetailsScreenState();
}

class _PnrDetailsScreenState extends State<PnrDetailsScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  PnrDataServices pnrDataServices = PnrDataServices();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  void _onSubmit(String userid, String pnr) async {
    setState(() => _isLoading = true);
    await pnrDataServices.getPnrDataFromApi(context, pnr, userid);

    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> openMap(double latitude, double longitude) async {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      await launchUrl(Uri.parse(googleUrl));
    }

    var pnrDataProvider = Provider.of<PnrDataProvider>(context, listen: false);
    TextEditingController textEditingController = TextEditingController();

    GlobalVariable globalVariable = GlobalVariable();

    return Scaffold(
        floatingActionButton:
            context.watch<PnrDataProvider>().pnrDataModel.pnr != ''
                ? null
                : FloatingActionButton.extended(
                    backgroundColor: primaryColor,
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      var userid = sharedPreferences.getInt('userid');
                      if (formKey.currentState!.validate()) {
                        _onSubmit(userid.toString(),
                            textEditingController.text.trim());
                      }
                    },
                    label: Row(
                      children: [
                        _isLoading
                            ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(2.0),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text('Verify PNR')
                      ],
                    ),
                  ),
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("PNR Details"),
        ),
        //backgroundColor: Color(0xFFf5f7f9),
        body: context.watch<PnrDataProvider>().pnrDataModel.pnr != ''
            ? SafeArea(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //padding: EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //border: Border.all(width: 0.5, color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.1, color: Colors.grey)),
                            ),
                            child: Row(
                              children: [
                                const Text("PNR #"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    pnrDataProvider.pnrDataModel.pnr.toString())
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.1, color: Colors.grey)),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.train,
                                  color: lightRedColor,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    "${pnrDataProvider.pnrDataModel.trainNo} - ${pnrDataProvider.pnrDataModel.trainName}")
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.1, color: Colors.grey)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(pnrDataProvider
                                            .pnrDataModel.boardingStationName),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "(${pnrDataProvider.pnrDataModel.boardingPoint})"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "${pnrDataProvider.pnrDataModel.doj} ${pnrDataProvider.pnrDataModel.departureTime}")
                                      ],
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_right),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(pnrDataProvider
                                            .pnrDataModel.destinationName),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            '(${pnrDataProvider.pnrDataModel.reservationUpto})'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "${pnrDataProvider.pnrDataModel.destinationDoj} ${pnrDataProvider.pnrDataModel.arrivalTime}")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.1, color: Colors.grey)),
                            ),
                            child: Row(
                              children: [
                                const Text("Class"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(pnrDataProvider
                                    .pnrDataModel.pnrDataModelClass)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                const Text("Quota"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(pnrDataProvider.pnrDataModel.quota)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: secondaryColor,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('From'),
                                    Text(pnrDataProvider
                                        .pnrDataModel.boardingStationName)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('To'),
                                    Text(pnrDataProvider
                                        .pnrDataModel.destinationName)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Coach'),
                                    Text(pnrDataProvider.passengerModel.coach)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Berth'),
                                    Text(pnrDataProvider.passengerModel.berth),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Duration'),
                                    Text(pnrDataProvider.pnrDataModel.duration)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Expected Platform'),
                                    Text(pnrDataProvider
                                        .pnrDataModel.expectedPlatformNo)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {
                          var toDetails = jsonDecode(
                              pnrDataProvider.pnrDataModel.toDetails);
                          openMap(double.parse(toDetails["latitude"]),
                              double.parse(toDetails["longitude"]));
                        },
                        icon: const Icon(
                          FontAwesomeIcons.locationDot,
                          color: secondaryColor,
                        ),
                        label: const Text('View Your Destination'))
                  ],
                ),
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.length != 10) {
                                  return 'check your pnr number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5, color: lightRedColor)),
                                label: Text('PNR NUMBER'),
                              ),
                              controller: textEditingController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}

// SafeArea(
//         child: Column(
//           //crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration:
//                     const BoxDecoration(color: Colors.white, boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 10,
//                   )
//                 ]),
//                 child: const Text(
//                   '9946498616',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black, fontSize: 30),
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   TitleTextWidget(title: 'Train Details'),
//                   ShowDetailsWidget(items: [
//                     DetailsItemsWidget(
//                         title: 'Train Number', subtitle: '17307'),
//                     DetailsItemsWidget(
//                         title: 'Train Name',
//                         subtitle: 'Chennai Egmore Guruvayur Express.'),
//                   ]),
//                   TitleTextWidget(title: 'Train Details'),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
