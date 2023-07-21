import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class MessageTile extends StatefulWidget {

  final String message;
  final String senderId;
  final bool isSentByMe;
  const MessageTile({Key? key, required this.message, required this.senderId, required this.isSentByMe}) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 7
      ),
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.6, left: 20, top: 20),
      decoration: BoxDecoration(
        color: Constants.mainColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child:  Text(
        widget.message,
        textAlign: TextAlign.start,
        style: customTextStyle(17, Colors.white, FontWeight.normal),
      ),
    );
  }
}
