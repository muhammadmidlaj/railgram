import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String profileurl;
  final String username;
  final String comment;
  final String date;
  const CommentCard(
      {super.key,
      required this.profileurl,
      required this.username,
      required this.comment,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  profileurl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        comment,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.reply),
          //     ),
          //     const Text('Reply'),
          //   ],
          // ),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    //   child: Row(
    //     children: [
    //       CircleAvatar(
    //         radius: 18,
    //       ),
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               RichText(
    //                 text: TextSpan(
    //                   children: [
    //                     TextSpan(
    //                         text: 'username',
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                         )),
    //                     TextSpan(
    //                         text: ' comment section',
    //                         style: TextStyle(color: Colors.red)),
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 4),
    //                 child: Text(
    //                   'date',
    //                   // DateFormat.yMMMd().format(
    //                   //   snap.data()['datePublished'].toDate(),

    //                   style: const TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(8),
    //         child: const Icon(
    //           Icons.favorite,
    //           size: 16,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
