import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';

class QuestionViewWidget extends StatelessWidget {
  final String username;
  final String title;
  final String? profileurl;
  final String created;
  const QuestionViewWidget(
      {super.key,
      required this.username,
      required this.title,
      required this.profileurl,
      required this.created});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  onBackgroundImageError: (exception, stackTrace) {
                    return;
                  },
                  backgroundImage: NetworkImage(
                    profileurl ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(convertDateToDays(created),
                          style: const TextStyle(
                            fontSize: 15,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
