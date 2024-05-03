
import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/Report/service/reportService.dart';

class ReportProblemWidget extends StatefulWidget {
  const ReportProblemWidget({super.key});

  @override
  State<ReportProblemWidget> createState() => _ReportProblemWidgetState();
}

class _ReportProblemWidgetState extends State<ReportProblemWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(10),
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
            height: 20,
          ),
          const Text('Report a problem',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          const Text(
              'Did you encounter a problem ? Please describe your issue to help us find and fix the issue faster',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey)),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _controller,
            maxLines: 10,
            onSubmitted: (value) {},
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                hintText: "Briefly explain what happened or what's not working",
                hintMaxLines: 2,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 0.5,
                  color: primaryColor,
                ))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  ReportService reportService = ReportService();
                  String value = _controller.text;
                  if (value.isNotEmpty) {
                    reportService.addReport('', value, "application", context);
                    _controller.clear();
                  } else {
                    showSnackBar(context, "Please enter a description");
                  }
                },
                icon: const Icon(Icons.report),
                label: const Text('Report')),
          )
        ],
      ),
    );
  }
}
