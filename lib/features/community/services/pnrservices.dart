import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/error_handling.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/community/provider/pnrprovider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PnrServices {
  Future<bool> getPnrDetails(BuildContext context, String pnr) async {
    bool pnrVerified = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid = preferences.getInt('userid');
    http.Response response = await http
        .get(Uri.parse('$api_url/pnr/$pnr'), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    });
    bool verified = verifyPnr(response.body);
    if (!verified) {
      showSnackBar(context, 'PNR verification failed');
      pnrVerified = false;
    } else {
      Map<String, dynamic> pnrmap = jsonDecode(response.body);
      List<dynamic> pnrdata = pnrmap['data'];
      DateTime date = DateTime.parse(pnrdata[0]['SourceDoj']);
      var localdate = date.toLocal();
      var newFormat = DateFormat("yyyy-MM-dd");
      String updatedDate = newFormat.format(localdate);
      print(updatedDate);

      http.Response pnrResponse =
          await http.post(Uri.parse('$api_url/api/addPnrData'), body: {
        'Pnr': pnr.toString(),
        'TrainNo': pnrdata[0]['TrainNo'].toString(),
        'TrainName': pnrdata[0]['TrainName'],
        'SourceDoj': formatDate(pnrdata[0]['SourceDoj']),
        'DestinationDoj': formatDate(pnrdata[0]['DestinationDoj']),
        'BookingDate': formatDate(pnrdata[0]['BookingDate']),
        'From': pnrdata[0]['From'],
        'To': pnrdata[0]['To'],
        'DepartureTime': pnrdata[0]['DepartureTime'],
        'ArrivalTime': pnrdata[0]['ArrivalTime'],
        'userid': userid.toString()
      }, headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      });

      apiErrorHandle(
        response: pnrResponse,
        context: context,
        onSuccess: () {
          preferences.setString('pnrnumber', pnr);

          pnrVerified = true;
        },
      );
    }
    return pnrVerified;
  }

  bool verifyPnr(String pnrdetails) {
    Map<String, dynamic> pnrmap = jsonDecode(pnrdetails);
    List<dynamic> pnrdata = pnrmap['data'];

    if (pnrdata.isEmpty ||
        pnrdata[0]['TrainNo'] == null ||
        pnrdata[0]['TrainName'] == null) {
      return false;
    } else {
      return true;
    }
  }

  void getVerifiedPnrData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid = preferences.getInt('userid');
    var pnrno = preferences.getString('pnrnumber');
    var params = {"pnrno": pnrno, "userid": userid.toString()};
    Uri uri = Uri.parse('$api_url/api/getPnrData');
    final newUri = uri.replace(queryParameters: params);
    http.Response response = await http.get(newUri, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    PnrProvider pnrProvider = Provider.of<PnrProvider>(context, listen: false);
    pnrProvider.setPnrModel(response.body);

    print(pnrProvider.pnrVerifiedModel.trainNo);

    pnrExpireCheck(context);
  }

  pnrExpireCheck(BuildContext context) async {
    print("checking");
    PnrProvider pnrProvider = Provider.of<PnrProvider>(context, listen: false);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var convertedDate =
        convertDate(pnrProvider.pnrVerifiedModel.destinationDoj);

    var date = formatDate(convertedDate.toString());

    Duration duration = DateTime.now().difference(DateTime.parse(date));

    if (duration.inDays <= 5) {
      print("pnr is expired");
      showSnackBar(context, 'PNR number is expired');
      pnrProvider.isPnrVerified = false;
      sharedPreferences.remove('pnrnumber');
      sharedPreferences.setBool('pnrVerified', false);
    } else {
      pnrProvider.isPnrVerified = true;
      sharedPreferences.setBool('pnrVerified', true);
    }
  }
}
