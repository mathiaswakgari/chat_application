import 'package:chat_application/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'customStyle.dart';

class SearchTile extends StatelessWidget {
  final String userName;
  final String label;
  final String uid;

  const SearchTile(
      {Key? key,
      required this.userName,
      required this.label,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Constants.mainColor,
        child: const Icon(CupertinoIcons.person, color: Colors.white,),
      ),
      title: Text(
        userName,
        style: customTextStyle(15, Colors.black, FontWeight.normal),
      ),
      trailing: CustomButton(onPressed: (){}, label: label),
    ) ;


  }
}
