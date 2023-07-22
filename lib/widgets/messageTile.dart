import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String senderId;
  final bool isSentByMe;
  final String userNameInitial;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.senderId,
      required this.isSentByMe,
      required this.userNameInitial})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      margin: widget.isSentByMe
          ? EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.2, left: 20, top: 20)
          : EdgeInsets.only(
              left:  MediaQuery.of(context).size.width * 0.2,
              right: 20,
              top: 20),
      decoration: BoxDecoration(
          color: widget.isSentByMe
              ? Constants.mainColor
              : Constants.secondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: !widget.isSentByMe
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    radius: 12,
                    child: Text(widget.userNameInitial),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.message,
                    textAlign: TextAlign.start,
                    style: customTextStyle(17, Colors.white, FontWeight.normal),
                  ),
                ),
              ],
            )
          : Text(
              widget.message,
              textAlign: TextAlign.start,
              style: customTextStyle(17, Colors.white, FontWeight.normal),
            ),
    );
  }
}
