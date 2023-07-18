import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference p2pCollection =
      FirebaseFirestore.instance.collection("p2pChat");

  Future createUser(String fullName, String email) async {
    return await userCollection.doc(uid).set(
        {"fullName": fullName, "email": email, "privateChats": [], "uid": uid});
  }

  Future getUser() async {
    QuerySnapshot querySnapshot =
        await userCollection.where("uid", isEqualTo: uid).get();
    return querySnapshot;
  }

  Future updateUser(String fullName, String password) async {
    try {
      print(uid);
      await userCollection.doc(uid).update({
        "fullName": fullName,
      });
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
      return true;
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  getUserChats() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createChat(String peerOneId, String peerTwoId) async {
    DocumentReference chatDocumentReference = await p2pCollection.add({
      "members": [],
      "recentMessage": "",
      "chatId": "",
      "recentMessageSender": "",
      "messages": [],
      "lastUpdated": ""
    });

    await chatDocumentReference.update({
      "chatId": chatDocumentReference.id,
      "members": FieldValue.arrayUnion([peerOneId, peerTwoId]),
      "lastUpdated": Timestamp.now().toString()
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);

    return await userDocumentReference.update({
      "privateChats": FieldValue.arrayUnion([chatDocumentReference.id])
    });
  }

  Future getChat(String chatId) async {
    return p2pCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  searchUsers(String name)async{
    return userCollection.where("fullName", isLessThanOrEqualTo: name).get();
  }

  Future<bool> isChatStarted(String userId)async{
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot userDocumentSnapshot = await userDocumentReference.get();

    List<dynamic> chats = await userDocumentSnapshot['privateChats'];
    if(chats.contains(userId)){
      return true;
    }
    else{
      return false;
    }

  }

}
