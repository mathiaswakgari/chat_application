import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});

   final CollectionReference userCollection = FirebaseFirestore
       .instance.collection("users");
   final CollectionReference p2pCollection = FirebaseFirestore
       .instance.collection("p2pChat");

   Future createUser(String fullName, String email)async {
     return await userCollection.doc(uid).set({
       "fullName": fullName,
       "email": email,
       "privateChats": [],
       "uid": uid
     });
   }

}