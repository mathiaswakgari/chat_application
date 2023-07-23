import 'package:chat_application/helper/functions.dart';
import 'package:chat_application/screens/profile_screen.dart';
import 'package:chat_application/screens/search_screen.dart';
import 'package:chat_application/services/auth_service.dart';
import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/chatTile.dart';
import 'package:chat_application/widgets/customDrawer.dart';
import 'package:chat_application/widgets/customSpacing.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "";
  String email = "";
  Stream? privateChats;
  QuerySnapshot? userInfo;

  getUserData() async {
    await HelperFunctions.getUserEmailSharedPreferences().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        fullName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserChats()
        .then((snapshot) {
      setState(() {
        privateChats = snapshot;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUser()
        .then((value) {
      setState(() {
        userInfo = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    child: const SearchScreen(),
                    type: PageTransitionType.bottomToTop));
              },
              child: const Icon(CupertinoIcons.search),
            ),
          )
        ],
        title: Text(
          "Messages",
          style: customTextStyle(20, Colors.white, FontWeight.normal),
        ),
        centerTitle: true,
        backgroundColor: Constants.mainColor,
      ),
      drawer: CustomDrawer(fullName: fullName!, email: email!, index: 1),
      body: chatList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageTransition(
              child: const SearchScreen(),
              type: PageTransitionType.bottomToTop));
        },
        backgroundColor: Constants.mainColor,
        elevation: 0,
        child: const Icon(
          CupertinoIcons.chat_bubble_fill,
          color: Colors.white,
        ),
      ),
    );
  }

  chatList() {
    return StreamBuilder(
        stream: privateChats,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Constants.mainColor,
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data['privateChats'] != null) {
              if (snapshot.data['privateChats'].length != 0) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('p2pChat')
                        .where('combinedId',
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapOne) {
                      if (snapOne.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Constants.mainColor,
                          ),
                        );
                      } else if (snapOne.hasData) {
                        return ListView.builder(
                            itemCount: snapOne.data?.docs.length,
                            itemBuilder: (context, indexOne) {
                              dynamic peerNames =
                                  snapOne.data?.docs[indexOne]['members'];
                              dynamic peerName = peerNames
                                  .where((element) =>
                                      element['id'] !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .toList();
                              peerName = peerName[0]['name'];
                              if (userInfo != null) {
                                return ChatTile(
                                    peerName: peerName,
                                    peerNameInitial: peerName.substring(0, 1),
                                    chatId: snapOne.data?.docs[indexOne]
                                        ['chatId'],
                                    recentMessage: snapOne.data?.docs[indexOne]
                                        ['recentMessage']);
                              } else {}
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Constants.mainColor,
                          ),
                        );
                      }
                    });

                // show actual data
              } else {
                // return no private chats
                return Center(
                  child: Text(
                    "You have no chats.",
                    style: customTextStyle(20, Colors.black, FontWeight.normal),
                  ),
                );
              }
            } else {
              // return no private chats
              return Center(
                child: Text(
                  "You have no chats.",
                  style: customTextStyle(20, Colors.black, FontWeight.normal),
                ),
              );
            }
          }
          return Center(
            child: Text(
              "You have no chats.",
              style: customTextStyle(20, Colors.black, FontWeight.normal),
            ),
          );
        });
  }
}
