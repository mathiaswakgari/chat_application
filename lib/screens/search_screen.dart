import 'package:chat_application/services/database_service.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:chat_application/widgets/customStyle.dart';
import 'package:chat_application/widgets/searchTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  QuerySnapshot? querySnapshot;
  bool _hasSearched = false;
  bool _hasChatAlready = false;

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        elevation: 0,
        title: Text(
          "Search",
          style: customTextStyle(20, Colors.white, FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   color: Constants.mainColor,
          //   decoration: BoxDecoration(
          //
          //   ),
          //   width: MediaQuery.of(context).size.width,
          //   child: Text("To", style: customTextStyle(13, Colors.white, FontWeight.bold),),
          // ),
          Container(
            color: Constants.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search users...",
                        hintStyle: customTextStyle(
                            15, Colors.white, FontWeight.normal),
                        border: InputBorder.none),
                    style: customTextStyle(15, Colors.white, FontWeight.normal),
                  ),
                ),
                GestureDetector(
                  onTap: search,
                  child: Container(
                    // padding: EdgeInsets.only(bottom: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Constants.mainColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: usersList(),
                )
        ],
      ),
    );
  }

  search() async {
    if (searchController.text.isNotEmpty) {
      await DatabaseService()
          .searchUsers(searchController.text)
          .then((snapshot) {
        setState(() {
          querySnapshot = snapshot;
          _hasSearched = true;
          _isLoading = false;
        });
      });
    }
  }

  /*hasStartedChatAlready(String chatId, String userId) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .isChatStarted(userId)
        .then((value) {
      setState(() {
        _hasChatAlready = value;
      });
    });
  }*/

  usersList() {
    return _hasSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: querySnapshot!.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: querySnapshot!.docs[index].get('fullName'),
                  uid : querySnapshot!.docs[index].get('uid'),
             );
            })
        : Container();
  }
}
