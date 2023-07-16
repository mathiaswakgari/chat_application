import 'package:chat_application/helper/functions.dart';
import 'package:chat_application/screens/profile_screen.dart';
import 'package:chat_application/services/auth_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customDrawer.dart';
import 'package:chat_application/widgets/customSpacing.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName;
  String? email;

  getUserData() async {
    await HelperFunctions.getUserEmailSharedPreferences().then((value) {
      setState(() {
        email = value;
      });
    });
    await HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        fullName = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(CupertinoIcons.search),
              ),
            )
          ],
          title: Text(
            "Messages",
            style: customTextStyle(20, Colors.white, FontWeight.normal),
          ),
          centerTitle: true,
          backgroundColor: Constants.mainColor,
        ),
        drawer: CustomDrawer(fullName: fullName!, email: email!, index: 1));
  }
}
