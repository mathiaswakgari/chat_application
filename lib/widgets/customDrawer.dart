import 'package:chat_application/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../services/auth_service.dart';
import '../shared/constants.dart';
import 'customSpacing.dart';
import 'customStyle.dart';

class CustomDrawer extends StatelessWidget {
  final String fullName;
  final String email;
  final int index;

  const CustomDrawer(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            fullName,
            style: customTextStyle(20, Colors.black, FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          const CustomSpacing(),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              if (index == 1) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        child: const HomeScreen(),
                        type: PageTransitionType.rightToLeft));
              }
            },
            selectedColor: Constants.secondaryColor,
            selected: index == 1,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(
              CupertinoIcons.chat_bubble_2_fill,
              color: index != 1 ? Constants.mainColor : null,
            ),
            title: Text("Messages",
                style: customTextStyle(15, Colors.black, FontWeight.normal)),
          ),
          ListTile(
            onTap: () {
              if (index == 2) {
                Navigator.pop(context);
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        child: ProfileScreen(fullName: fullName, email: email),
                        type: PageTransitionType.rightToLeft));
              }
            },
            selectedColor: Constants.secondaryColor,
            selected: index == 2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: index != 2 ? Constants.mainColor : null,
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
    );
  }
}
