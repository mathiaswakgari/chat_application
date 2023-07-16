import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

void showSnackBar(context, color, message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: customTextStyle(12, Colors.white, FontWeight.normal),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
    )
  );
}