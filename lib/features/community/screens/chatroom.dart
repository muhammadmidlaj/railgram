import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/community/provider/chatprovider.dart';
import 'package:railgram/features/community/widgets/otherMessage_widget.dart';
import 'package:railgram/features/community/widgets/ownMessage_widget.dart';
import 'package:railgram/features/messages/MODEL/messageModel.dart';
import 'package:railgram/features/messages/services/messageservice.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: must_be_immutable
class ChatRomm extends StatefulWidget {
  final String userid;
  final String username;
  final String trainnumber;
  final String trainname;
  final String profileurl;
  const ChatRomm(
      {super.key,
      required this.userid,
      required this.username,
      required this.trainnumber,
      required this.trainname,
      required this.profileurl});

  @override
  State<ChatRomm> createState() => _ChatRommState();
}

class _ChatRommState extends State<ChatRomm> {
  IO.Socket? socket;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatProvider chatProviderr = ChatProvider();
  MessageService messageService = MessageService();
  List<ChatroomMessageModel> messageListold = [];
  @override
  void initState() {
    // print("initial user id  : ${widget.userid}");
    // print(widget.trainnumber);
    Future.delayed(Duration.zero, () {
      final chat = Provider.of<ChatProvider>(context, listen: false);
      chat.clearMsgList();
    });
    getOldMessage(context, widget.trainnumber);
    initSocket(context);

    recieveMessage(context);

    // Future.delayed(Duration.zero, () {
    //   final chat = Provider.of<ChatProvider>(context, listen: false);
    //   log(messageListold.length.toString());
    //   chat.setOldMessage(messageListold);
    //   log(chat.messageList.length.toString());
    // });
    super.initState();
  }

  void getOldMessage(
    BuildContext context,
    String communityid,
  ) async {
    messageListold = await messageService.getAllMessages(
        context: context, communityid: communityid);
    final chat = Provider.of<ChatProvider>(context, listen: false);
    chat.setOldMessage(messageListold);
    log(messageListold.length.toString());
    log(chat.messageList.length.toString());
  }

  initSocket(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    // socket = IO.io(api_url, <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false
    // });
    socket = IO.io(
        api_url,
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .setQuery({"roomid": widget.username})
            .build());

    socket!.connect();
    print(socket!.id);
    socket!.onConnect((_) {
      print('connected');
      createRoom();

      //socket!.emit('sendMsg', 'test emit event ${socket!.id}');
    });
  }

  void createRoom() {
    socket!.emit('createRoom', widget.trainnumber);
  }

  void recieveMessage(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    //chatProvider.clearMsgList();

    socket!.on('sendMsgServer', (msg) {
      print(msg);

      if (msg["user_id"].toString() != userProvider.user.userid.toString()) {
        chatProvider.setMessage(ChatroomMessageModel.fromJson(msg));
        // for (var i in chatProvider.messageList) {
        //   print("data on list ${i.message}");
        // }
      } else {}
    });
  }

  void sendMessage(
      {required BuildContext context,
      required String msg,
      required String sender,
      required String userid,
      required String profileurl}) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    MessageService messageService = MessageService();
    // MessageModel ownMessage = MessageModel(
    //     type: "ownMsg",
    //     message: msg,
    //     createdat: "time",
    //     sender: sender,
    //     userid: userid,
    //     profileurl: profileurl);
    //messageList.add(ownMessage);
    //chatProvider.setMessage(ownMessage);

    ChatroomMessageModel chatroomMessageModel = ChatroomMessageModel(
        messageId: "",
        userId: userid,
        username: sender,
        communityId: widget.trainnumber,
        createdat: DateTime.now().toString(),
        message: msg,
        messageType: "ownMessage",
        profileimgurl: profileurl);

    chatProvider.setMessage(chatroomMessageModel);

    messageService.addMessagesToDB(
        widget.trainnumber, userid, chatroomMessageModel, context);

    socket!.emit('sendMsg', {
      "messageType": "ownMsg",
      "message": msg,
      "createdat": DateTime.now().toString(),
      "username": sender,
      "user_id": userid,
      "profileimgurl": profileurl,
      "community_id": widget.trainnumber
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    socket!.disconnect();
    socket!.destroy();
    socket!.dispose();

    chatProviderr.messageList.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("${widget.trainname} - ChatRoom"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Column(
              children: [
                // if (messageListold.isEmpty)
                //   Container(
                //     height: 20,
                //     child: Text("empty"),
                //   )
                // else
                //   Expanded(
                //     child: ListView.builder(
                //       scrollDirection: Axis.vertical,
                //       shrinkWrap: true,
                //       itemCount: messageListold.length,
                //       itemBuilder: (context, index) {
                //         if (messageListold[index].userId ==
                //             userProvider.user.userid.toString()) {
                //           return OwnMsgWidget(
                //               username: messageListold[index].username,
                //               message: messageListold[index].message,
                //               time: messageListold[index].createdat,
                //               userid: messageListold[index].userId,
                //               profileurl: messageListold[index].profileimgurl);
                //         } else {
                //           return OtherMsgWidget(
                //               username: messageListold[index].username,
                //               message: messageListold[index].message,
                //               time: messageListold[index].createdat,
                //               userid: messageListold[index].userId,
                //               profileurl: messageListold[index].profileimgurl);
                //         }
                //       },
                //     ),
                //   ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (context
                              .watch<ChatProvider>()
                              .messageList[index]
                              .userId ==
                          userProvider.user.userid.toString()) {
                        return OwnMsgWidget(
                            profileurl: widget.profileurl,
                            username: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .username,
                            message: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .message,
                            time: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .createdat,
                            userid: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .userId);
                      } else {
                        return OtherMsgWidget(
                            profileurl: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .profileimgurl,
                            username: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .username,
                            message: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .message,
                            time: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .createdat,
                            userid: context
                                .watch<ChatProvider>()
                                .messageList[index]
                                .userId);
                      }
                    },
                    itemCount: context.watch<ChatProvider>().messageList.length,
                  ),
                ),
                Container(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut);
                                var userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                print("send button userid : ${widget.userid}");
                                if (_textEditingController.text.isNotEmpty) {
                                  sendMessage(
                                      profileurl: widget.profileurl,
                                      context: context,
                                      msg: _textEditingController.text,
                                      sender: widget.username,
                                      userid:
                                          userProvider.user.userid.toString());
                                  _textEditingController.clear();
                                }
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
