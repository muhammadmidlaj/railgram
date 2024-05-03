class PnrVerifiedModel {
  PnrVerifiedModel({
    required this.id,
    required this.pnr,
    required this.trainNo,
    required this.trainName,
    required this.sourceDoj,
    required this.destinationDoj,
    required this.bookingDate,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.userid,
  });

  String id;
  String pnr;
  String trainNo;
  String trainName;
  String sourceDoj;
  String destinationDoj;
  String bookingDate;
  String from;
  String to;
  String departureTime;
  String arrivalTime;
  String userid;

  factory PnrVerifiedModel.fromJson(Map<String, dynamic> json) =>
      PnrVerifiedModel(
        id: json["id"].toString(),
        pnr: json["Pnr"].toString(),
        trainNo: json["TrainNo"],
        trainName: json["TrainName"],
        sourceDoj: json["SourceDoj"],
        destinationDoj: json["DestinationDoj"],
        bookingDate: json["BookingDate"],
        from: json["From"],
        to: json["To"],
        departureTime: json["DepartureTime"],
        arrivalTime: json["ArrivalTime"],
        userid: json["userid"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Pnr": pnr,
        "TrainNo": trainNo,
        "TrainName": trainName,
        "SourceDoj": sourceDoj,
        "DestinationDoj": destinationDoj,
        "BookingDate": bookingDate,
        "From": from,
        "To": to,
        "DepartureTime": departureTime,
        "ArrivalTime": arrivalTime,
        "userid": userid,
      };
}
