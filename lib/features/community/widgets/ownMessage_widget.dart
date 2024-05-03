import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';

class OwnMsgWidget extends StatelessWidget {
  String username;
  String userid;
  String message;
  String time;
  String profileurl;
  OwnMsgWidget(
      {super.key,
      required this.username,
      required this.message,
      required this.time,
      required this.userid,
      required this.profileurl});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 60),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 0 = Send
// 1 = Recieved
_itemChat({int? chat, String? avatar, message, time}) {
  return Row(
    mainAxisAlignment:
        chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      avatar != null
          ? Avatar(
              image: avatar,
              size: 50,
            )
          : Text(
              '$time',
              style: TextStyle(color: Colors.grey.shade400),
            ),
      Flexible(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: chat == 0 ? Colors.indigo.shade100 : Colors.indigo.shade50,
            borderRadius: chat == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
          ),
          child: Text('$message'),
        ),
      ),
      chat == 1
          ? Text(
              '$time',
              style: TextStyle(color: Colors.grey.shade400),
            )
          : const SizedBox(),
    ],
  );
}

Widget _formChat() {
  return Positioned(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        color: Colors.white,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Type your message...',
            suffixIcon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.indigo),
              padding: const EdgeInsets.all(14),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    ),
  );
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  const Avatar({super.key, this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
