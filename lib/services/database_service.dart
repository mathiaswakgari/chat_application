import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
   
   Future getUser()async{
     QuerySnapshot querySnapshot = await userCollection.where(
         "uid", isEqualTo: uid).get();
     return querySnapshot;
   }

   Future updateUser(String fullName, String password)async{
     try{
       print(uid);
       await userCollection.doc(uid).update({
         "fullName": fullName,
       });
       await FirebaseAuth.instance.currentUser!.updatePassword(password);
       return true;
     }
     on FirebaseAuthException catch(error){
       return error.message;
     }
   }

}