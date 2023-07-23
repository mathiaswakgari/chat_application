import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChatTile extends StatefulWidget {
  final String peerName;
  final String peerNameInitial;
  final String chatId;
  final String recentMessage;

  const ChatTile(
      {Key? key,
      required this.peerName,
      required this.chatId,
      required this.recentMessage,
      required this.peerNameInitial})
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
        Navigator.of(context).push(PageTransition(
            child: ChatScreen(userName: widget.peerName, chatId: widget.chatId),
            type: PageTransitionType.rightToLeft));
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
                child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                widget.peerNameInitial,
                style: customTextStyle(20, Colors.white, FontWeight.normal),
              ),
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
