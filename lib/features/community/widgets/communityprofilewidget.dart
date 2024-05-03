import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';
import 'package:railgram/features/PnrNumber/screen/pnrdetailsscreen.dart';
import 'package:railgram/features/community/provider/communityprovider.dart';
import 'package:railgram/features/community/screens/chatroom.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:uuid/uuid.dart';

class CommunityProfileWidget extends StatefulWidget {
  final String communityname;
  final String trainnumber;
  final String rating;
  final String profileurl;
  final int index;
  const CommunityProfileWidget(
      {super.key,
      required this.communityname,
      required this.trainnumber,
      required this.rating,
      required this.profileurl,
      required this.index});

  @override
  State<CommunityProfileWidget> createState() => _CommunityProfileWidgetState();
}

class _CommunityProfileWidgetState extends State<CommunityProfileWidget> {
  TextEditingController textEditingController = TextEditingController();
  bool textEnable = true;
  bool privacy = true;
  showUserNameDialog(
      BuildContext context, TextEditingController controller, Uuid uuid) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    controller.text = userProvider.user.username;
                    textEnable = false;
                    privacy = false;
                  });
                },
                child: const Text(
                  'Click here to get your profilename',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextFormField(
                enabled: textEnable ? true : false,
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter your user name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  String username = controller.text;
                  String profileUrl = userProvider.user.profileimgurl;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatRomm(
                      profileurl: privacy ? '' : profileUrl,
                      trainname: widget.communityname,
                      trainnumber: widget.trainnumber,
                      userid: uuid.v1(),
                      username: username,
                    ),
                  ));
                  controller.clear();
                },
                child: const Text('Join'))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: lightRedColor,
                  child: Image.network(
                    "https://res.cloudinary.com/drbqzoiks/image/upload/v1683478289/photo-1592844002373-a55ecd7af140_cnkult.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    height: 124,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.train,
                          color: secondaryColor,
                        ),
                      ),
                      title: Text(widget.communityname),
                      subtitle: Text('${widget.trainnumber}  ${widget.rating}'),
                      trailing: IconButton(
                          onPressed: () async {
                            showUserNameDialog(
                                context, textEditingController, uuid);
                            textEditingController.clear();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.rocketchat,
                            color: primaryColor,
                            semanticLabel: 'ChatRoom',
                          )),
                    )
                    // Column(
                    //   children: const [
                    //     Text('Rating'),
                    //     Text('TrainName'),
                    //     Text('Train NO')
                    //   ],
                    // ),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
