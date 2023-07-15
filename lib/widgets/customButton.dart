import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const CustomButton(
      {
        Key? key,
        required this.onPressed,
        required this.label,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Constants.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),)
      ),
        child: Text(
          label,
          style: customTextStyle(
              15,
              Colors.white,
              FontWeight.w600
          ),
        ),
    );
  }
}
