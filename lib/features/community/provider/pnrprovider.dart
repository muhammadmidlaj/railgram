import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/features/community/model/pnrmodel.dart';

class PnrProvider extends ChangeNotifier {
  bool isPnrVerified = false;
  PnrVerifiedModel pnrVerifiedModel = PnrVerifiedModel(
      id: '',
      pnr: '',
      trainNo: '',
      trainName: '',
      sourceDoj: '',
      destinationDoj: '',
      bookingDate: '',
      from: '',
      to: '',
      departureTime: '',
      arrivalTime: '',
      userid: '');

  void setPnrModel(String pnrdata) {
    Map<String, dynamic> pnrmap = jsonDecode(pnrdata);

    pnrVerifiedModel = PnrVerifiedModel.fromJson(pnrmap['data'][0][0]);

    notifyListeners();
  }
}
