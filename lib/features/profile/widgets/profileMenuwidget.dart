import 'package:flutter/material.dart';
import 'package:railgram/constants/global_variable.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: iconColor,
        size: 20,
      ),
    );
  }
}
