import 'package:flutter/material.dart';
import 'package:railgram/features/Report/service/reportService.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({super.key, required this.postid, required this.index});
  final String postid;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              spreadRadius: 10,
              color: Colors.grey,
              offset: Offset(0, -1))
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Report',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Why are you Reporting this post',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          ReportTextWidget(
            reportText: 'I Just Dont Like It',
            postid: postid,
            index: index,
          ),
          ReportTextWidget(
            reportText: "It's Spam",
            postid: postid,
            index: index,
          ),
          ReportTextWidget(
            reportText: 'Hate Speech',
            postid: postid,
            index: index,
          ),
          ReportTextWidget(
            reportText: 'False Information',
            postid: postid,
            index: index,
          ),
          ReportTextWidget(
            reportText: 'Scam or Fraud',
            postid: postid,
            index: index,
          )
        ],
      ),
    );
  }
}

class ReportTextWidget extends StatelessWidget {
  const ReportTextWidget(
      {super.key,
      required this.reportText,
      required this.postid,
      required this.index});
  final String reportText;
  final String postid;
  final int index;

  @override
  Widget build(BuildContext context) {
    ReportService reportService = ReportService();

    return InkWell(
      onTap: () {
        reportService.addReport(postid, reportText, "post", context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        child: Text(
          reportText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
