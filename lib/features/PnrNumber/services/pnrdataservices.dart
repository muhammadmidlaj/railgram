import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/PnrNumber/model/pnrapimodel.dart';
import 'package:railgram/features/PnrNumber/model/pnrdatamodel.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PnrDataServices {
  getPnrDataFromApi(BuildContext context, String pnr, String userid) async {
    //#1 check same pnr on db
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool value = false;
    http.Response check = await getPnrForVerification(pnr);

    if (check.statusCode == 200) {
      log(check.body);
      Map<String, dynamic> map = jsonDecode(check.body);
      List<dynamic> list = map['data'];

      //#2 get data from irtc server
      var parameter = {"pnrNumber": pnr};
      var url = Uri.parse("https://irctc1.p.rapidapi.com/api/v3/getPNRStatus");
      url = url.replace(queryParameters: parameter);

      http.Response response = await http.get(url, headers: <String, String>{
        "X-RapidAPI-Key": "API_KEY",
        "X-RapidAPI-Host": "irctc1.p.rapidapi.com"
      });

      if (response.statusCode == 200) {
        log(response.body);
        Map<String, dynamic> map = jsonDecode(response.body);
        PnrApiModel pnrApiModel = PnrApiModel.fromJson(map['data']);
        if (pnrApiModel.trainName.isEmpty || pnrApiModel.trainNo.isEmpty) {
          //show snackbar
          //pnr in not valid
          showSnackBarOnError(
              context: context, text: "Enter a valid pnr number");
          value = false;
        } else {
          log('message');
          if (list.isEmpty) {
            //#4 add pnr data to db
            http.Response res = await addPnrDetailsToDB(pnrApiModel, userid);
            log(res.body);
            httpErrorHandle(
                response: res,
                context: context,
                onSuccess: () {
                  showSnackBar(context, "Pnr details added");
                });
            http.Response passengerResponse = await addPassengerDetails(
                pnrApiModel.passengerStatus[0], pnrApiModel.pnr, userid);
            httpErrorHandle(
              response: passengerResponse,
              context: context,
              onSuccess: () {
                showSnackBar(context, "passenger details added");
              },
            );
            sharedPreferences.setString('PNRNUMBER', pnrApiModel.pnr);

            getPnrDataDetails(context);
            getPassengerDetails(context);

            value = true;
          } else {
            if (int.parse(pnrApiModel.passengerCount) == 1) {
              //#5 show snackbar("pnr number alredy used")
              showSnackBarOnError(
                  context: context, text: "Check your PNR number");
              value = false;
            } else {
              //#6 get data from passenger info table
              int passengerCount = await getPassengerCount(pnr);
              if (passengerCount == int.parse(pnrApiModel.passengerCount)) {
                //show snackbar pnr already used
                showSnackBarOnError(
                    context: context, text: "Check your PNR number");
                value = false;
              } else {
                http.Response res =
                    await addPnrDetailsToDB(pnrApiModel, userid);
                httpErrorHandle(
                    response: res,
                    context: context,
                    onSuccess: () {
                      showSnackBar(context, "Pnr details added");
                    });
                http.Response passengerResponse = await addPassengerDetails(
                    pnrApiModel.passengerStatus[passengerCount],
                    pnrApiModel.pnr,
                    userid);
                httpErrorHandle(
                  response: passengerResponse,
                  context: context,
                  onSuccess: () {
                    showSnackBar(context, "passenger details added");
                  },
                );
                sharedPreferences.setString('PNRNUMBER', pnrApiModel.pnr);
                getPnrDataDetails(context);
                getPassengerDetails(context);
                value = true;
              }
            }
          }
        }
      } else {
        log('server error');
        showSnackBarOnError(context: context, text: "server not found");
        return value;
      }
    } else {
      log('server error');
      showSnackBarOnError(context: context, text: "server not found");
      value = false;
    }
    return value;
  }

  getPnrForVerification(String pnr) async {
    log(pnr);
    var parameter = {"Pnr": pnr};
    var url = Uri.parse("$api_url/railgram-api/pnrData/getPnrForVerification");
    url = url.replace(queryParameters: parameter);
    http.Response response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    return response;
  }

  getPassengerCount(String pnr) async {
    var parameter = {"Pnr": pnr};
    var url = Uri.parse("$api_url/railgram-api/pnrData/getPassengerCount");
    url = url.replace(queryParameters: parameter);
    http.Response response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map['data'][0]["count(Pnr)"];
    } else {
      return 0;
    }
  }

  addPnrDetailsToDB(PnrApiModel pnrApiModel, String userid) async {
    PnrDataModel pnrDataModel = PnrDataModel(
        pnrDataModelClass: pnrApiModel.pnrApiModelClass,
        id: "",
        pnr: pnrApiModel.pnr,
        trainNo: pnrApiModel.trainNo,
        trainName: pnrApiModel.trainName,
        doj: pnrApiModel.doj,
        bookingDate: pnrApiModel.bookingDate,
        quota: pnrApiModel.quota,
        destinationDoj: pnrApiModel.destinationDoj,
        sourceDoj: pnrApiModel.sourceDoj,
        from: pnrApiModel.from,
        to: pnrApiModel.to,
        reservationUpto: pnrApiModel.reservationUpto,
        boardingPoint: pnrApiModel.boardingPoint,
        chartPrepared: pnrApiModel.chartPrepared,
        boardingStationName: pnrApiModel.boardingStationName,
        trainStatus: pnrApiModel.trainStatus,
        trainCancelledFlag: pnrApiModel.trainCancelledFlag,
        reservationUptoName: pnrApiModel.reservationUptoName,
        passengerCount: pnrApiModel.passengerCount,
        departureTime: pnrApiModel.departureTime,
        arrivalTime: pnrApiModel.arrivalTime,
        expectedPlatformNo: pnrApiModel.expectedPlatformNo,
        sourceName: pnrApiModel.sourceName,
        destinationName: pnrApiModel.destinationName,
        duration: pnrApiModel.duration,
        fromDetails: jsonEncode(pnrApiModel.fromDetails),
        toDetails: jsonEncode(pnrApiModel.toDetails),
        boardingPointDetails: jsonEncode(pnrApiModel.boardingPointDetails),
        reservationUptoDetails: jsonEncode(pnrApiModel.reservationUptoDetails),
        userid: userid);

    http.Response response =
        await http.post(Uri.parse("$api_url/railgram-api/pnrData/addPnrdata"),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: pnrDataModel.toJson());

    return response;
  }

  addPassengerDetails(
      PassengerStatus passenger, String pnr, String userid) async {
    PassengerModel passengerModel = PassengerModel(
        id: "",
        pnr: pnr,
        number: passenger.number.toString(),
        coach: passenger.coach,
        berth: passenger.berth,
        bookingStatus: passenger.bookingStatus,
        currentStatus: passenger.currentStatus,
        coachPosition: passenger.coachPosition,
        bookingBerthNo: passenger.bookingBerthNo,
        bookingCoachId: passenger.bookingCoachId,
        bookingStatusNew: passenger.bookingStatusNew,
        currentCoachId: passenger.currentCoachId,
        bookingBerthCode: passenger.bookingBerthCode ?? "",
        currentBerthCode: passenger.currentBerthCode,
        currentStatusNew: passenger.currentStatusNew,
        userid: userid);

    http.Response response = await http.post(
        Uri.parse('$api_url/railgram-api/pnrData/addPassengerDetails'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: passengerModel.toJson());

    return response;
  }

  getPnrDataDetails(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? pnrno = sharedPreferences.getString('PNRNUMBER');
    int? userid = sharedPreferences.getInt('userid');
    if (pnrno != null) {
      var url = Uri.parse("$api_url/railgram-api/pnrData/getPnrDetails");
      var parameter = {"Pnr": pnrno, "userid": userid.toString()};
      url = url.replace(queryParameters: parameter);
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      apiErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var pnrdataProvider =
              Provider.of<PnrDataProvider>(context, listen: false);
          pnrdataProvider.setPnrDataModel(response.body);
        },
      );
    }
  }

  getPassengerDetails(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? pnrno = sharedPreferences.getString('PNRNUMBER');
    int? userid = sharedPreferences.getInt('userid');
    if (pnrno != null || pnrno == null) {
      var url =
          Uri.parse("$api_url/railgram-api/pnrData/getPassengerDetailsForUser");
      var parameter = {"Pnr": pnrno, "userid": userid.toString()};
      url = url.replace(queryParameters: parameter);
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      apiErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var passengerProvider =
              Provider.of<PnrDataProvider>(context, listen: false);
          passengerProvider.setPassengerModel(response.body);
        },
      );
    }
  }

  deletePnronExpiry(String userid) async {
    var url = Uri.parse("$api_url/railgram-api/pnrData/deletePnrDetails");
    var parameter = {"userid": userid};
    url = url.replace(queryParameters: parameter);
    await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  pnrDataExpiryCheck(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var pnrdataProvider = Provider.of<PnrDataProvider>(context, listen: false);
    String? pnrnumber = preferences.getString('PNRNUMBER');
    int? userid = preferences.getInt('userid');
    if (pnrnumber != null || pnrnumber == null) {
      DateTime destinationDoj =
          formatDateForPnr(pnrdataProvider.pnrDataModel.destinationDoj);

      Duration duration = DateTime.now().difference(destinationDoj);
      log(duration.inDays.toString());
      if (duration.inDays >= 1) {
        log('pnr expired');
        deletePnronExpiry(userid.toString());
        preferences.remove('PNRNUMBER');
      }

      // DateTime destinationDate = DateTime.parse(
      //     formatDate(pnrdataProvider.pnrDataModel.destinationDoj));
      // Duration dur = destinationDate.difference(now);
      // log(destinationDate.toString());
      // log(dur.inDays.toString());
    }
  }

  DateTime formatDateForPnr(String date) {
    var inputFormat = DateFormat("yyyy-dd-MM");
    var formattedInputDate = inputFormat.parse(date);
    var outPutformat = DateFormat("yyyy-MM-dd");
    var newDate = outPutformat.format(formattedInputDate);
    return DateTime.parse(newDate);

    // var localDate = newDate.toLocal();
    // var newFormat = DateFormat("yyyy-dd-MM");
    // String updatedDate = newFormat.format(localDate);
    // return updatedDate;
  }
}
