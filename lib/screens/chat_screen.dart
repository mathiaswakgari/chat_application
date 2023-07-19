import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/customTextFieldThree.dart';
import 'package:chat_application/widgets/customTextFieldTwo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String uid;
  final String chatId;

  const ChatScreen(
      {Key? key,
      required this.userName,
      required this.uid,
      required this.chatId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chat;
  TextEditingController textEditingController = TextEditingController();

  getChat() {
    DatabaseService().getChat('chatId').then((value) {
      setState(() {
        chat = value;
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
          "Hannah",
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
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.circular(0)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFieldThree(
                        textEditingController: textEditingController,
                        ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(child: Icon(Icons.send, color: Constants.mainColor,)),
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

  sendMessage(){

  }
  charMessage(){
     
  }
}
