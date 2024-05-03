import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';

class PnrVerificationWidget extends StatefulWidget {
  const PnrVerificationWidget({super.key});

  @override
  State<PnrVerificationWidget> createState() => _PnrVerificationWidgetState();
}

class _PnrVerificationWidgetState extends State<PnrVerificationWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('Verify PNR ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          const Text('Enter your 10 digit PNR number',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey)),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _controller,
            onSubmitted: (value) {},
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
              width: 0.5,
              color: lightRedColor,
            ))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  String value = _controller.text;
                  if (value.isNotEmpty) {
                    _controller.clear();
                  } else {
                    showSnackBar(context, "Please enter a number");
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
