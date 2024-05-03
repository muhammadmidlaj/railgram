import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:railgram/constants/global_variable.dart';

import '../features/posts/globalPost/screen/createpost.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titile;
  final String profileImage;
  final bool newToole = false;

  const CustomeAppBar(
      {super.key, required this.profileImage, required this.titile});
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: const Icon(FontAwesomeIcons.house),
      title: Text(
        titile,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // Get.to(CreatePage());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreatePostPage(communityId: null),
              ));
            },
            icon: const Icon(
              FontAwesomeIcons.penToSquare,
              color: Colors.white,
            )),
        // InkWell(
        //   onTap: () => Scaffold.of(context).openEndDrawer(),
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(profileImage),
        //   ),
        // )
      ],
    );
  }
}
