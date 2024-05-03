import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';

class AboutUser extends StatelessWidget {
  const AboutUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Username'),
          Text(context.watch<UserProvider>().user.username),
          const Text('Full Name'),
          Text(
              '${context.watch<UserProvider>().user.firstname} ${context.watch<UserProvider>().user.lastname}'),
          const Text('Email'),
          Text(context.watch<UserProvider>().user.email),
        ],
      ),
    );
  }
}
