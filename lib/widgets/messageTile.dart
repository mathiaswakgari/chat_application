import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {

  final String message;
  final String sender;
  final bool isSentByMe;
  const MessageTile({Key? key, required this.message, required this.sender, required this.isSentByMe}) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
