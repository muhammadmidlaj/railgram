// To parse this JSON data, do
//
//     final pnrApiModel = pnrApiModelFromJson(jsonString);

import 'dart:convert';

PnrApiModel pnrApiModelFromJson(String str) =>
    PnrApiModel.fromJson(json.decode(str));

String pnrApiModelToJson(PnrApiModel data) => json.encode(data.toJson());

class PnrApiModel {
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
  String pnrApiModelClass;
  String chartPrepared;
  String boardingStationName;
  String trainStatus;
  String trainCancelledFlag;
  String reservationUptoName;
  String passengerCount;
  List<PassengerStatus> passengerStatus;
  String departureTime;
  String arrivalTime;
  String expectedPlatformNo;
  String bookingFare;
  String ticketFare;
  String coachPosition;
  double rating;
  double foodRating;
  double punctualityRating;
  double cleanlinessRating;
  String sourceName;
  String destinationName;
  String duration;
  int ratingCount;
  bool hasPantry;
  Details fromDetails;
  Details toDetails;
  Details boardingPointDetails;
  Details reservationUptoDetails;

  PnrApiModel({
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
    required this.pnrApiModelClass,
    required this.chartPrepared,
    required this.boardingStationName,
    required this.trainStatus,
    required this.trainCancelledFlag,
    required this.reservationUptoName,
    required this.passengerCount,
    required this.passengerStatus,
    required this.departureTime,
    required this.arrivalTime,
    required this.expectedPlatformNo,
    required this.bookingFare,
    required this.ticketFare,
    required this.coachPosition,
    required this.rating,
    required this.foodRating,
    required this.punctualityRating,
    required this.cleanlinessRating,
    required this.sourceName,
    required this.destinationName,
    required this.duration,
    required this.ratingCount,
    required this.hasPantry,
    required this.fromDetails,
    required this.toDetails,
    required this.boardingPointDetails,
    required this.reservationUptoDetails,
  });

  factory PnrApiModel.fromJson(Map<String, dynamic> json) => PnrApiModel(
        pnr: json["Pnr"],
        trainNo: json["TrainNo"],
        trainName: json["TrainName"],
        doj: json["Doj"],
        bookingDate: json["BookingDate"],
        quota: json["Quota"],
        destinationDoj: json["DestinationDoj"],
        sourceDoj: json["SourceDoj"],
        from: json["From"],
        to: json["To"],
        reservationUpto: json["ReservationUpto"],
        boardingPoint: json["BoardingPoint"],
        pnrApiModelClass: json["Class"],
        chartPrepared: json["ChartPrepared"].toString(),
        boardingStationName: json["BoardingStationName"],
        trainStatus: json["TrainStatus"],
        trainCancelledFlag: json["TrainCancelledFlag"].toString(),
        reservationUptoName: json["ReservationUptoName"],
        passengerCount: json["PassengerCount"].toString(),
        passengerStatus: List<PassengerStatus>.from(
            json["PassengerStatus"].map((x) => PassengerStatus.fromJson(x))),
        departureTime: json["DepartureTime"],
        arrivalTime: json["ArrivalTime"],
        expectedPlatformNo: json["ExpectedPlatformNo"] ?? '',
        bookingFare: json["BookingFare"],
        ticketFare: json["TicketFare"],
        coachPosition: json["CoachPosition"],
        rating: json["Rating"]?.toDouble(),
        foodRating: json["FoodRating"]?.toDouble(),
        punctualityRating: json["PunctualityRating"]?.toDouble(),
        cleanlinessRating: json["CleanlinessRating"]?.toDouble(),
        sourceName: json["SourceName"],
        destinationName: json["DestinationName"],
        duration: json["Duration"],
        ratingCount: json["RatingCount"],
        hasPantry: json["HasPantry"],
        fromDetails: Details.fromJson(json["FromDetails"]),
        toDetails: Details.fromJson(json["ToDetails"]),
        boardingPointDetails: Details.fromJson(json["BoardingPointDetails"]),
        reservationUptoDetails:
            Details.fromJson(json["ReservationUptoDetails"]),
      );

  Map<String, dynamic> toJson() => {
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
        "Class": pnrApiModelClass,
        "ChartPrepared": chartPrepared,
        "BoardingStationName": boardingStationName,
        "TrainStatus": trainStatus,
        "TrainCancelledFlag": trainCancelledFlag,
        "ReservationUptoName": reservationUptoName,
        "PassengerCount": passengerCount,
        "PassengerStatus":
            List<dynamic>.from(passengerStatus.map((x) => x.toJson())),
        "DepartureTime": departureTime,
        "ArrivalTime": arrivalTime,
        "ExpectedPlatformNo": expectedPlatformNo,
        "BookingFare": bookingFare,
        "TicketFare": ticketFare,
        "CoachPosition": coachPosition,
        "Rating": rating,
        "FoodRating": foodRating,
        "PunctualityRating": punctualityRating,
        "CleanlinessRating": cleanlinessRating,
        "SourceName": sourceName,
        "DestinationName": destinationName,
        "Duration": duration,
        "RatingCount": ratingCount,
        "HasPantry": hasPantry,
        "FromDetails": fromDetails.toJson(),
        "ToDetails": toDetails.toJson(),
        "BoardingPointDetails": boardingPointDetails.toJson(),
        "ReservationUptoDetails": reservationUptoDetails.toJson(),
      };
}

class Details {
  String category;
  String division;
  String latitude;
  String longitude;
  String state;
  String stationCode;
  String stationName;

  Details({
    required this.category,
    required this.division,
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.stationCode,
    required this.stationName,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        category: json["category"],
        division: json["division"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        state: json["state"],
        stationCode: json["stationCode"],
        stationName: json["stationName"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "division": division,
        "latitude": latitude,
        "longitude": longitude,
        "state": state,
        "stationCode": stationCode,
        "stationName": stationName,
      };
}

class PassengerStatus {
  dynamic pnr;
  int number;
  dynamic prediction;
  dynamic predictionPercentage;
  dynamic confirmTktStatus;
  String coach;
  String berth;
  String bookingStatus;
  String currentStatus;
  String coachPosition;
  String bookingBerthNo;
  String bookingCoachId;
  String bookingStatusNew;
  String bookingStatusIndex;
  String currentBerthNo;
  String currentCoachId;
  dynamic bookingBerthCode;
  String currentBerthCode;
  String currentStatusNew;
  String currentStatusIndex;

  PassengerStatus({
    this.pnr,
    required this.number,
    this.prediction,
    this.predictionPercentage,
    this.confirmTktStatus,
    required this.coach,
    required this.berth,
    required this.bookingStatus,
    required this.currentStatus,
    required this.coachPosition,
    required this.bookingBerthNo,
    required this.bookingCoachId,
    required this.bookingStatusNew,
    required this.bookingStatusIndex,
    required this.currentBerthNo,
    required this.currentCoachId,
    this.bookingBerthCode,
    required this.currentBerthCode,
    required this.currentStatusNew,
    required this.currentStatusIndex,
  });

  factory PassengerStatus.fromJson(Map<String, dynamic> json) =>
      PassengerStatus(
        pnr: json["Pnr"],
        number: json["Number"],
        prediction: json["Prediction"],
        predictionPercentage: json["PredictionPercentage"],
        confirmTktStatus: json["ConfirmTktStatus"],
        coach: json["Coach"],
        berth: json["Berth"].toString(),
        bookingStatus: json["BookingStatus"],
        currentStatus: json["CurrentStatus"],
        coachPosition: json["CoachPosition"] ?? '',
        bookingBerthNo: json["BookingBerthNo"],
        bookingCoachId: json["BookingCoachId"],
        bookingStatusNew: json["BookingStatusNew"],
        bookingStatusIndex: json["BookingStatusIndex"],
        currentBerthNo: json["CurrentBerthNo"] ?? '',
        currentCoachId: json["CurrentCoachId"] ?? '',
        bookingBerthCode: json["BookingBerthCode"] ?? '',
        currentBerthCode: json["CurrentBerthCode"] ?? '',
        currentStatusNew: json["CurrentStatusNew"] ?? '',
        currentStatusIndex: json["CurrentStatusIndex"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Pnr": pnr,
        "Number": number,
        "Prediction": prediction,
        "PredictionPercentage": predictionPercentage,
        "ConfirmTktStatus": confirmTktStatus,
        "Coach": coach,
        "Berth": berth,
        "BookingStatus": bookingStatus,
        "CurrentStatus": currentStatus,
        "CoachPosition": coachPosition,
        "BookingBerthNo": bookingBerthNo,
        "BookingCoachId": bookingCoachId,
        "BookingStatusNew": bookingStatusNew,
        "BookingStatusIndex": bookingStatusIndex,
        "CurrentBerthNo": currentBerthNo,
        "CurrentCoachId": currentCoachId,
        "BookingBerthCode": bookingBerthCode,
        "CurrentBerthCode": currentBerthCode,
        "CurrentStatusNew": currentStatusNew,
        "CurrentStatusIndex": currentStatusIndex,
      };
}
