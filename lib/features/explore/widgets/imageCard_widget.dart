import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  final String username;
  final String? profileurl;
  final String? communityid;
  final String imageurl;
  const ImageCardWidget(
      {super.key,
      required this.imageurl,
      required this.profileurl,
      required this.username,
      required this.communityid});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ClipRRect(
            // clip the image to a circle
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  imageurl,
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(1),
                  colorBlendMode: BlendMode.modulate,
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                //   child: Container(
                //     padding: const EdgeInsets.all(4),
                //     decoration: BoxDecoration(
                //         color: Colors.grey[100],
                //         backgroundBlendMode: BlendMode.overlay,
                //         border: Border.all(width: 0.1),
                //         borderRadius: BorderRadius.circular(8)),
                //     child: Row(
                //       children: [
                //         CircleAvatar(
                //           onBackgroundImageError: (exception, stackTrace) {
                //             return;
                //           },
                //           backgroundImage: NetworkImage(profileurl ?? ""),
                //           radius: 15,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 7),
                //           child: Text(
                //             username,
                //             style: const TextStyle(fontWeight: FontWeight.w600),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}
