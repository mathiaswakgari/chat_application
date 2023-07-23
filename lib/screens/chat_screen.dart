import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/customTextFieldThree.dart';
import 'package:chat_application/widgets/customTextFieldTwo.dart';
import 'package:chat_application/widgets/messageTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String? uid;
  final String chatId;

  const ChatScreen(
      {Key? key, required this.userName, this.uid, required this.chatId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;
  TextEditingController textEditingController = TextEditingController();

  getChat() {
    DatabaseService().getChat(widget.chatId).then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        title: Text(
          widget.userName,
          style: customTextStyle(20, Colors.white, FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              CupertinoIcons.info,
              color: Colors.white,
            ),
          )
        ],
        elevation: 0,
        toolbarHeight: 65,
      ),
      body: Stack(
        children: [
          chatMessage(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: Constants.mainColor,
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFieldThree(
                      textEditingController: textEditingController,
                    ),
                  ),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.send,
                        color: Constants.mainColor,
                      )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessage = {
        "message": textEditingController.text,
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "chatId": widget.chatId,
        "time": DateTime.now().microsecondsSinceEpoch
      };

      DatabaseService().sendMessage(widget.chatId, chatMessage);

      setState(() {
        textEditingController.clear();
      });
    }
  }

  chatMessage() {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    List dataList =
                        snapshot.data.docs.map((e) => e.data()).toList();
                    dataList.sort((a, b) => a['time'].compareTo(b['time']));

                    return MessageTile(
                        message: dataList[index]['message'],
                        senderId: dataList[index]['senderId'],
                        isSentByMe: FirebaseAuth.instance.currentUser!.uid ==
                            snapshot.data.docs[index]['senderId'],
                        userNameInitial: widget.userName.substring(0, 1));
                  },
                )
              : Container();
        });
  }
}
