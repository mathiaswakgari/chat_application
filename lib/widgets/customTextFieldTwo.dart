import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

class CustomTextFieldTwo extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController textEditingController;
  final bool isEnabled;
  // final String initialValue;
  const CustomTextFieldTwo(
      {
        Key? key,
        required this.label,
        required this.isPassword,
        required this.textEditingController, required this.isEnabled,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: isEnabled,
      validator: (value){
        if(isPassword){
          if (value!.length < 8) {
            return "Password must be at least 8 characters";
          }
          else {
            return null;
          }
        }
        else if(label == "Full Name"){
          if(value!.isEmpty){
            return "Full name can't be empty";
          }
          else{
            return null;
          }

        }
        else{
          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!) ? null : "Please enter a valid email";
        }
      },
      decoration: InputDecoration(
          labelStyle: const TextStyle(
              color: Colors.black
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Constants.mainColor,
                width: 2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Constants.mainColor,
                width: 2
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Constants.mainColor,
                width: 2
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          label: Text(
            label,
            style: customTextStyle(15, Colors.grey[600]!, FontWeight.w500),
          ),

      ),
      obscureText: isPassword,
    );
  }
}
