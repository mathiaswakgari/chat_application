import 'package:chat_application/widgets/app_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ChatNova",
                  style: appStyle(30, Colors.black, FontWeight.bold),
                ),
                Text(
                    "Login now to connect with your loved ones",
                    style: appStyle(15, Colors.black, FontWeight.w500)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
