import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customDrawer.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String email;

  const ProfileScreen({Key? key, required this.fullName, required this.email})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Profile",
          style: customTextStyle(20, Colors.white, FontWeight.normal),
        ),
      ),
      drawer: CustomDrawer(
          fullName: widget.fullName, email: widget.email, index: 2),
    );
  }
}
