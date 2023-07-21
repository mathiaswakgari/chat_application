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

  getP2pChats() async {
    return p2pCollection.snapshots();
  }

  getUsers() async {
    return userCollection.snapshots();
  }

  Future createChat(String peerOneId, String peerTwoId, String peerOneName,
      String peerTwoName) async {
    List<dynamic> chatIds = [];
    bool? peerToPeerAlready;

    DocumentReference peerOneDocumentReference = userCollection.doc(peerOneId);
    DocumentReference peerTwoDocumentReference = userCollection.doc(peerTwoId);
    // DocumentReference chatDocumentReference = p2pCollection.;

    DocumentSnapshot peerOneSnapshot = await peerOneDocumentReference.get();
    DocumentSnapshot peerTwoSnapshot = await peerTwoDocumentReference.get();
    // DocumentSnapshot chatDocumentSnapshot = await ;

    List peerOneChats = peerOneSnapshot['privateChats'];
    List peerTwoChats = peerTwoSnapshot['privateChats'];

    QuerySnapshot querySnapshot = await p2pCollection.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (peerOneChats.isEmpty) {
      DocumentReference chatDocumentReference = await p2pCollection.add({
        "members": {},
        "recentMessage": "",
        "chatId": "",
        "recentMessageSender": "",
        "messages": [],
        "lastUpdated": "",
        "combinedId": []
      });

      await chatDocumentReference.update({
        "chatId": chatDocumentReference.id,
        "members": {
          {'name': peerOneName, 'id': peerOneId},
          {'name': peerTwoName, 'id': peerTwoId}
        },
        "lastUpdated": Timestamp.now().toString(),
        "combinedId": FieldValue.arrayUnion([peerOneId, peerTwoId])
      });

      await peerOneDocumentReference.update({
        "privateChats": FieldValue.arrayUnion([chatDocumentReference.id])
      });
      await peerTwoDocumentReference.update({
        "privateChats": FieldValue.arrayUnion([chatDocumentReference.id])
      });

      DocumentSnapshot chatDocumentSnapshot = await chatDocumentReference.get();
      return true;
    } else {
      for (int i = 0; i < allData.length; i++) {
        chatIds.add((allData[i] as Map<dynamic, dynamic>)['chatId']);
      }
      for (int i = 0; i < peerTwoChats.length; i++) {
        if (peerOneChats.contains(peerTwoChats[i])) {
          peerToPeerAlready = true;
          break;
        } else {
          peerToPeerAlready = false;
        }
      }
      if (peerToPeerAlready == false) {
        DocumentReference chatDocumentReference = await p2pCollection.add({
          "members": {},
          "recentMessage": "",
          "chatId": "",
          "recentMessageSender": "",
          "messages": [],
          "lastUpdated": "",
          "combinedId": [],
        });

        await chatDocumentReference.update({
          "chatId": chatDocumentReference.id,
          "members": {
            {'name': peerOneName, 'id': peerOneId},
            {'name': peerTwoName, 'id': peerTwoId}
          },
          "lastUpdated": Timestamp.now().toString(),
          "combinedId": FieldValue.arrayUnion([peerOneId, peerTwoId])
        });

        await peerOneDocumentReference.update({
          "privateChats": FieldValue.arrayUnion([chatDocumentReference.id])
        });
        await peerTwoDocumentReference.update({
          "privateChats": FieldValue.arrayUnion([chatDocumentReference.id])
        });

        DocumentSnapshot chatDocumentSnapshot =
            await chatDocumentReference.get();
        return true;
      } else {
        return false;
      }
    }
  }

  Future getChat(String chatId) async {
    return p2pCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  searchUsers(String name) async {
    return userCollection.where("fullName", isLessThanOrEqualTo: name).get();
  }

  Future<bool> isChatStarted(String peerOneId, String peerTwoId) async {
    List<dynamic> chatIds = [];
    bool? peerToPeerAlready;

    DocumentReference peerOneDocumentReference = userCollection.doc(peerOneId);
    DocumentReference peerTwoDocumentReference = userCollection.doc(peerTwoId);
    // DocumentReference chatDocumentReference = p2pCollection.;

    DocumentSnapshot peerOneSnapshot = await peerOneDocumentReference.get();
    DocumentSnapshot peerTwoSnapshot = await peerTwoDocumentReference.get();
    // DocumentSnapshot chatDocumentSnapshot = await ;

    List peerOneChats = peerOneSnapshot['privateChats'];
    List peerTwoChats = peerTwoSnapshot['privateChats'];

    QuerySnapshot querySnapshot = await p2pCollection.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (peerOneChats.isEmpty) {
      return false;
    } else {
      for (int i = 0; i < allData.length; i++) {
        chatIds.add((allData[i] as Map<dynamic, dynamic>)['chatId']);
      }
      for (int i = 0; i < peerTwoChats.length; i++) {
        if (peerOneChats.contains(peerTwoChats[i])) {
          peerToPeerAlready = true;
          break;
        }
      }
      if (peerToPeerAlready == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  sendMessage(String chatId, Map<String, dynamic> message) async {
    p2pCollection.doc(chatId).collection('messages').add(message);
    p2pCollection.doc(chatId).update({
      "recentMessage": message['message'],
      "recentMessageTime": message['time'].toString()
    });
  }
}
