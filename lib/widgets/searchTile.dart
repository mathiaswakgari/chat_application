import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/widgets/customButton.dart';
import 'package:chat_application/widgets/snackBar.dart';
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
  bool _isChatAvailaible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChatAvailable();
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
            if (_isChatAvailaible) {
              showSnackBar(context, Constants.secondaryColor,
                  "Chat is Already Available");
            } else {
              await DatabaseService().createChat(
                  FirebaseAuth.instance.currentUser!.uid, widget.uid);
              setState(() {});
              showSnackBar(context, Constants.mainColor,
                  "Chat created succesfully");
            }
          },
          label: _isChatAvailaible ? "Send" : "Start"),
    );
  }

  isChatAvailable() async {
    await DatabaseService()
        .isChatStarted(FirebaseAuth.instance.currentUser!.uid, widget.uid)
        .then((value) {
      setState(() {
        _isChatAvailaible = value;
      });
    });
  }
}
