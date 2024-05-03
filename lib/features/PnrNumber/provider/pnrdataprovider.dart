import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:railgram/features/PnrNumber/model/pnrdatamodel.dart';

class PnrDataProvider extends ChangeNotifier {
  PnrDataModel _pnrDataModel = PnrDataModel(
      id: '',
      pnr: '',
      trainNo: '',
      trainName: '',
      doj: '',
      bookingDate: '',
      quota: '',
      destinationDoj: '',
      sourceDoj: '',
      from: '',
      to: '',
      reservationUpto: '',
      boardingPoint: '',
      pnrDataModelClass: '',
      chartPrepared: '',
      boardingStationName: '',
      trainStatus: '',
      trainCancelledFlag: '',
      reservationUptoName: '',
      passengerCount: '',
      departureTime: '',
      arrivalTime: '',
      expectedPlatformNo: '',
      sourceName: '',
      destinationName: '',
      duration: '',
      fromDetails: '',
      toDetails: '',
      boardingPointDetails: '',
      reservationUptoDetails: '',
      userid: '');

  PassengerModel _passengerModel = PassengerModel(
      id: "",
      pnr: "",
      number: "",
      coach: "",
      berth: "",
      bookingStatus: "",
      currentStatus: "",
      coachPosition: "",
      bookingBerthNo: "",
      bookingCoachId: "",
      bookingStatusNew: "",
      currentCoachId: "",
      bookingBerthCode: "",
      currentBerthCode: "",
      currentStatusNew: "",
      userid: "");

  PnrDataModel get pnrDataModel => _pnrDataModel;
  PassengerModel get passengerModel => _passengerModel;

  void setPnrDataModel(String response) {
    Map<String, dynamic> map = jsonDecode(response);
    List<dynamic> newmap = map['data'][0];

    _pnrDataModel = PnrDataModel.fromJson(newmap[0]);

    notifyListeners();
  }

  void setPassengerModel(String response) {
    Map<String, dynamic> map = jsonDecode(response);
    List<dynamic> newmap = map['data'][0];
    _passengerModel = PassengerModel.fromJson(newmap[0]);
    notifyListeners();
  }
}
