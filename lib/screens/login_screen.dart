import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customButton.dart';
import 'package:chat_application/widgets/customSpacing.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                Text(
                    "Login now to connect with your loved ones",
                    style: customTextStyle(15, Colors.black, FontWeight.w500)
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
                            label: 'Sign in'
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
    );
  }
}
