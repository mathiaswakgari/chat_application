import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  Stream<QuerySnapshot>? chat;


  getChat(){
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
            child: Icon(CupertinoIcons.info, color: Colors.white,),
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
    );
  }
}
