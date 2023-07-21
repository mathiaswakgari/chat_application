import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final String peerName;
  final String chatId;
  final String recentMessage;

  const ChatTile(
      {Key? key,
      required this.peerName,
      required this.chatId,
      required this.recentMessage})
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    //or return list tile
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ChatScreen(userName: widget.peerName, chatId: widget.chatId)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 65,
        decoration: BoxDecoration(
          color: Constants.mainColor,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: const CircleAvatar(
              backgroundColor: Colors.grey,
            )),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.peerName,
                    style: customTextStyle(14, Colors.white, FontWeight.bold),
                  ),
                  Text(
                    widget.recentMessage,
                    style: customTextStyle(
                        12, Colors.grey[200]!, FontWeight.normal),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
