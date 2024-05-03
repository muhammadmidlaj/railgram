// To parse this JSON data, do
//
//     final pnrDataModel = pnrDataModelFromJson(jsonString);

import 'dart:convert';

PnrDataModel pnrDataModelFromJson(String str) =>
    PnrDataModel.fromJson(json.decode(str));

String pnrDataModelToJson(PnrDataModel data) => json.encode(data.toJson());

class PnrDataModel {
  String id;
  String pnr;
  String trainNo;
  String trainName;
  String doj;
  String bookingDate;
  String quota;
  String destinationDoj;
  String sourceDoj;
  String from;
  String to;
  String reservationUpto;
  String boardingPoint;
  String pnrDataModelClass;
  String chartPrepared;
  String boardingStationName;
  String trainStatus;
  String trainCancelledFlag;
  String reservationUptoName;
  String passengerCount;
  String departureTime;
  String arrivalTime;
  String expectedPlatformNo;
  String sourceName;
  String destinationName;
  String duration;
  String fromDetails;
  String toDetails;
  String boardingPointDetails;
  String reservationUptoDetails;
  String userid;

  PnrDataModel({
    required this.id,
    required this.pnr,
    required this.trainNo,
    required this.trainName,
    required this.doj,
    required this.bookingDate,
    required this.quota,
    required this.destinationDoj,
    required this.sourceDoj,
    required this.from,
    required this.to,
    required this.reservationUpto,
    required this.boardingPoint,
    required this.pnrDataModelClass,
    required this.chartPrepared,
    required this.boardingStationName,
    required this.trainStatus,
    required this.trainCancelledFlag,
    required this.reservationUptoName,
    required this.passengerCount,
    required this.departureTime,
    required this.arrivalTime,
    required this.expectedPlatformNo,
    required this.sourceName,
    required this.destinationName,
    required this.duration,
    required this.fromDetails,
    required this.toDetails,
    required this.boardingPointDetails,
    required this.reservationUptoDetails,
    required this.userid,
  });

  factory PnrDataModel.fromJson(Map<String, dynamic> json) => PnrDataModel(
        id: json["id"],
        pnr: json["Pnr"],
        trainNo: json["TrainNo"].toString(),
        trainName: json["TrainName"],
        doj: json["Doj"] ?? '',
        bookingDate: json["BookingDate"] ?? '',
        quota: json["Quota"],
        destinationDoj: json["DestinationDoj"] ?? "",
        sourceDoj: json["SourceDoj"] ?? '',
        from: json["From"],
        to: json["To"],
        reservationUpto: json["ReservationUpto"],
        boardingPoint: json["BoardingPoint"],
        pnrDataModelClass: json["Class"],
        chartPrepared: json["ChartPrepared"],
        boardingStationName: json["BoardingStationName"],
        trainStatus: json["TrainStatus"],
        trainCancelledFlag: json["TrainCancelledFlag"],
        reservationUptoName: json["ReservationUptoName"],
        passengerCount: json["PassengerCount"].toString(),
        departureTime: json["DepartureTime"],
        arrivalTime: json["ArrivalTime"],
        expectedPlatformNo: json["ExpectedPlatformNo"].toString(),
        sourceName: json["SourceName"],
        destinationName: json["DestinationName"],
        duration: json["Duration"],
        fromDetails: json["FromDetails"],
        toDetails: json["ToDetails"],
        boardingPointDetails: json["BoardingPointDetails"],
        reservationUptoDetails: json["ReservationUptoDetails"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Pnr": pnr,
        "TrainNo": trainNo,
        "TrainName": trainName,
        "Doj": doj,
        "BookingDate": bookingDate,
        "Quota": quota,
        "DestinationDoj": destinationDoj,
        "SourceDoj": sourceDoj,
        "From": from,
        "To": to,
        "ReservationUpto": reservationUpto,
        "BoardingPoint": boardingPoint,
        "Class": pnrDataModelClass,
        "ChartPrepared": chartPrepared,
        "BoardingStationName": boardingStationName,
        "TrainStatus": trainStatus,
        "TrainCancelledFlag": trainCancelledFlag,
        "ReservationUptoName": reservationUptoName,
        "PassengerCount": passengerCount,
        "DepartureTime": departureTime,
        "ArrivalTime": arrivalTime,
        "ExpectedPlatformNo": expectedPlatformNo,
        "SourceName": sourceName,
        "DestinationName": destinationName,
        "Duration": duration,
        "FromDetails": fromDetails,
        "ToDetails": toDetails,
        "BoardingPointDetails": boardingPointDetails,
        "ReservationUptoDetails": reservationUptoDetails,
        "userid": userid,
      };
}

PassengerModel passengerModelFromJson(String str) =>
    PassengerModel.fromJson(json.decode(str));

String passengerModelToJson(PassengerModel data) => json.encode(data.toJson());

class PassengerModel {
  String id;
  String pnr;
  String number;
  String coach;
  String berth;
  String bookingStatus;
  String currentStatus;
  String coachPosition;
  String bookingBerthNo;
  String bookingCoachId;
  String bookingStatusNew;
  String currentCoachId;
  String bookingBerthCode;
  String currentBerthCode;
  String currentStatusNew;
  String userid;

  PassengerModel({
    required this.id,
    required this.pnr,
    required this.number,
    required this.coach,
    required this.berth,
    required this.bookingStatus,
    required this.currentStatus,
    required this.coachPosition,
    required this.bookingBerthNo,
    required this.bookingCoachId,
    required this.bookingStatusNew,
    required this.currentCoachId,
    required this.bookingBerthCode,
    required this.currentBerthCode,
    required this.currentStatusNew,
    required this.userid,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) => PassengerModel(
        id: json["id"],
        pnr: json["Pnr"],
        number: json["Number"].toString(),
        coach: json["Coach"],
        berth: json["Berth"],
        bookingStatus: json["BookingStatus"] ?? '',
        currentStatus: json["CurrentStatus"] ?? '',
        coachPosition: json["CoachPosition"] ?? '',
        bookingBerthNo: json["BookingBerthNo"] ?? '',
        bookingCoachId: json["BookingCoachId"] ?? '',
        bookingStatusNew: json["BookingStatusNew"] ?? '',
        currentCoachId: json["CurrentCoachId"] ?? '',
        bookingBerthCode: json["BookingBerthCode"] ?? '',
        currentBerthCode: json["CurrentBerthCode"] ?? '',
        currentStatusNew: json["CurrentStatusNew"] ?? '',
        userid: json["userid"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Pnr": pnr,
        "Number": number,
        "Coach": coach,
        "Berth": berth,
        "BookingStatus": bookingStatus,
        "CurrentStatus": currentStatus,
        "CoachPosition": coachPosition,
        "BookingBerthNo": bookingBerthNo,
        "BookingCoachId": bookingCoachId,
        "BookingStatusNew": bookingStatusNew,
        "CurrentCoachId": currentCoachId,
        "BookingBerthCode": bookingBerthCode,
        "CurrentBerthCode": currentBerthCode,
        "CurrentStatusNew": currentStatusNew,
        "userid": userid,
      };
}
