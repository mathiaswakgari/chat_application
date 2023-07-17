import 'package:chat_application/widgets/customButton.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'customStyle.dart';

class SearchTile extends StatelessWidget {
  final String userName;
  const SearchTile({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(1),
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
            color: Colors.redAccent,
            child: Column(
              children: [
                Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: customTextStyle(14, Colors.white, FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CustomButton(onPressed: () {}, label: "Send")
        ],
      ),
    );
  }
}
