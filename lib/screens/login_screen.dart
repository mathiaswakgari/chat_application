import 'package:chat_application/screens/signup_screen.dart';
import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customButton.dart';
import 'package:chat_application/widgets/customSpacing.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../helper/functions.dart';
import '../services/auth_service.dart';
import '../widgets/snackBar.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogging = false;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLogging
          ? Center(
              child: CircularProgressIndicator(
                color: Constants.mainColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ChatNova",
                          style: customTextStyle(
                              30, Colors.black, FontWeight.bold),
                        ),
                        Text("Login now to connect with your loved ones",
                            style: customTextStyle(
                                15, Colors.black, FontWeight.w500))
                      ],
                    ),
                  ),
                  const CustomSpacing(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/chat_one.png"),
                            fit: BoxFit.fill)),
                  ),
                  const CustomSpacing(),
                  SizedBox(
                    width: 375,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            icon: Icon(
                              CupertinoIcons.mail,
                              color: Constants.mainColor,
                            ),
                            label: "Email",
                            isPassword: false,
                            textEditingController: emailTextEditingController,
                          ),
                          const CustomSpacing(),
                          CustomTextField(
                            icon: Icon(
                              CupertinoIcons.lock,
                              color: Constants.mainColor,
                            ),
                            label: "Password",
                            isPassword: true,
                            textEditingController:
                                passwordTextEditingController,
                          ),
                          const CustomSpacing(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            child: CustomButton(
                              onPressed: login,
                              label: 'Sign in',
                            ),
                          ),
                          const CustomSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account yet?",
                                style: customTextStyle(
                                    12, Colors.black, FontWeight.normal),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const SignupScreen(),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  },
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2)),
                                  child: Text(
                                    "Register here",
                                    style: customTextStyle(12,
                                        Constants.mainColor, FontWeight.normal),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLogging = true;
      });
      await AuthService()
          .signIn(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) async {
        if (value == true) {
          QuerySnapshot querySnapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getUser();

          await HelperFunctions.saveUserLoggingStatus(true);
          await HelperFunctions.saveUserEmail(emailTextEditingController.text);
          await HelperFunctions.saveUserName(querySnapshot.docs[0]['fullName']);

          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomeScreen(),
                  type: PageTransitionType.leftToRight));
        } else {
          showSnackBar(context, const Color(0xFFE77200), value);
          setState(() {
            _isLogging = false;
          });
        }
      });
    }
  }
}
