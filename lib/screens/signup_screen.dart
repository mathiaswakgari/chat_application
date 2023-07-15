import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../widgets/customButton.dart';
import '../widgets/customSpacing.dart';
import '../widgets/customStyle.dart';
import '../widgets/customTextField.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ChatNova",
                  style: customTextStyle(30, Colors.black, FontWeight.bold),
                ),
                Container(
                  width: 350,
                  child: Text(
                      "Create your account now to connect with your friends",
                      textAlign: TextAlign.center,
                      style: customTextStyle(15, Colors.black, FontWeight.w500)
                  ),
                )
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
                    fit: BoxFit.fill)
            ),
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
                    label: "Full Name",
                    isPassword: false,
                    textEditingController: fullNameTextEditingController,
                  ),
                  const CustomSpacing(),
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
                    textEditingController: passwordTextEditingController,
                  ),
                  const CustomSpacing(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: CustomButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){}
                      },
                      label: 'Sign in',
                    ),
                  ),
                  const CustomSpacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account yet?",
                        style: customTextStyle(12, Colors.black, FontWeight.normal),
                      ),
                      TextButton(
                          onPressed: (){
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 2)
                          ),
                          child: Text(
                            "Register here",
                            style: customTextStyle(12, Constants.mainColor, FontWeight.normal),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );;
  }
}
