import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customButton.dart';
import 'package:chat_application/widgets/customDrawer.dart';
import 'package:chat_application/widgets/customSpacing.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/customTextFieldTwo.dart';
import 'package:chat_application/widgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isUpdating = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController.text = widget.fullName;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: 200,
                      color: Constants.mainColor,
                    ),
                    const CustomSpacing(),
                    CustomTextFieldTwo(
                      label: "Full Name",
                      isPassword: false,
                      textEditingController: fullNameController,
                      isEnabled: true,
                    ),
                    const CustomSpacing(),
                    CustomTextFieldTwo(
                      label: "Email",
                      isPassword: false,
                      textEditingController: emailController,
                      isEnabled: false,
                    ),
                    const CustomSpacing(),
                    CustomTextFieldTwo(
                      label: "Password",
                      isPassword: true,
                      textEditingController: passwordController,
                      isEnabled: true,
                    ),
                    const CustomSpacing(),
                    CustomButton(onPressed: update, label: "Update")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  update() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUpdating = true;
      });
      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .updateUser(fullNameController.text, passwordController.text).then((value){
            if(value == true){
              showSnackBar(context, Constants.mainColor, "Update successful.");

              Navigator.pop(context);
            }
            else{
            showSnackBar(context, Constants.secondaryColor, value);
        }
      });
    }
  }
}
