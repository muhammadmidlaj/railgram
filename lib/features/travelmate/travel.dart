import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';

class TravelmatePage extends StatelessWidget {
  const TravelmatePage({super.key});

  @override
  Widget build(BuildContext context) {
    var useprovider = Provider.of<UserProvider>(context, listen: false);
    String trainno = "16347";
    return Container(
        color: Colors.white,
        child: ElevatedButton(
          child: const Text('data'),
          onPressed: () {
            //CommunityServices().getAllCommunities(context)
            //CommunityServices().addCommunity(context, trainno)
            PostServices()
                .fetchUserPost(context, useprovider.user.userid.toString());
          },
        ));
  }
}
