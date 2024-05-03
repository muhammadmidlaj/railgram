import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';

class OtherMsgWidget extends StatefulWidget {
  String username;
  String userid;
  String message;
  String time;
  String profileurl;
  OtherMsgWidget(
      {super.key,
      required this.username,
      required this.message,
      required this.time,
      required this.userid,
      required this.profileurl});

  @override
  State<OtherMsgWidget> createState() => _OtherMsgWidgetState();
}

class _OtherMsgWidgetState extends State<OtherMsgWidget> {
  bool profileImgErrorOcuured = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 60),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.profileurl),
                onBackgroundImageError: (exception, stackTrace) {
                  setState(() {
                    profileImgErrorOcuured = true;
                  });
                },
                child: profileImgErrorOcuured ? const Icon(Icons.person) : null,
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
