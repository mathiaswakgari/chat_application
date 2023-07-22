import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/home_screen.dart';
import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/widgets/customButton.dart';
import 'package:chat_application/widgets/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'customStyle.dart';

class SearchTile extends StatefulWidget {
  final String userName;
  final String uid;


  const SearchTile({Key? key, required this.userName, required this.uid})
      : super(key: key);

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  bool _isChatAvailable = false;
  QuerySnapshot? userInfo;

  getUserInfo()async{
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUser().then((value){
      setState(() {
        userInfo = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChatAvailable();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Constants.mainColor,
        child: const Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.userName,
        style: customTextStyle(15, Colors.black, FontWeight.normal),
      ),
      trailing: CustomButton(
          onPressed: () async {
            if (_isChatAvailable) {
              showSnackBar(context, Constants.secondaryColor,
                  "Chat is Already Available");
            } else {
              await DatabaseService().createChat(
                  FirebaseAuth.instance.currentUser!.uid, widget.uid, userInfo?.docs[0]['fullName'],widget.userName).then((value){
                    setState(() {
                    });
              });
            }
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomeScreen()));
          },
          label: _isChatAvailable ? "Send" : "Start"),
    );
  }

  isChatAvailable() async {
    await DatabaseService()
        .isChatStarted(FirebaseAuth.instance.currentUser!.uid, widget.uid)
        .then((value) {
      setState(() {
        _isChatAvailable = value;
      });
    });
  }
}
