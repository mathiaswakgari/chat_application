import 'package:chat_application/helper/functions.dart';
import 'package:chat_application/screens/profile_screen.dart';
import 'package:chat_application/services/auth_service.dart';
import 'package:chat_application/shared/constants.dart';
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
      body: Center(
        child: ElevatedButton(
          onPressed: () => AuthService().signOut(),
          child: const Text("Log out"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 100),
          children: [
            Icon(
              CupertinoIcons.person_alt_circle,
              size: 150,
              color: Constants.mainColor,
            ),
            const CustomSpacing(),
            Text(
              fullName!,
              style: customTextStyle(20, Colors.black, FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            const CustomSpacing(),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selectedColor: Constants.secondaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
              title: Text("Messages",
                  style: customTextStyle(15, Colors.black, FontWeight.normal)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              selectedColor: Constants.secondaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Constants.mainColor,
              ),
              title: Text("Profile",
                  style: customTextStyle(15, Colors.black, FontWeight.normal)),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Sign out",
                          style: customTextStyle(
                              20, Colors.black, FontWeight.normal),
                        ),
                        content: Text(
                          "Are you sure you want to sign out?",
                          style: customTextStyle(
                              14, Colors.black, FontWeight.normal),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: customTextStyle(
                                    14, Colors.black, FontWeight.normal),
                              )),
                          TextButton(
                              onPressed: () {
                                AuthService().signOut().whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                });
                              },
                              child: Text(
                                "Sign out",
                                style: customTextStyle(
                                    14, Colors.redAccent, FontWeight.normal),
                              ))
                        ],
                      );
                    });
              },
              selectedColor: Constants.secondaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(
                Icons.logout,
                color: Constants.mainColor,
              ),
              title: Text("Sign out ",
                  style: customTextStyle(15, Colors.black, FontWeight.normal)),
            )
          ],
        ),
      ),
    );
  }
}
