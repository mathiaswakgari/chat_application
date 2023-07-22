import 'package:flutter/material.dart';
import 'customStyle.dart';

class CustomTextFieldThree extends StatelessWidget {
  final TextEditingController textEditingController;

  const CustomTextFieldThree({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 55.0),
      child: TextFormField(
        controller: textEditingController,
        validator: (value) {
          if (value!.length < 0) {
            return "Enter a message to send.";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          hintText: "Message...",
          hintStyle: customTextStyle(16, Colors.white, FontWeight.w500),
        ),
        maxLines: null,
      ),
    );
  }
}
