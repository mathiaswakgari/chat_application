import 'package:chat_application/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String fullName, String email, String password)async{
    try{
      
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password)).user!;
      DatabaseService(uid: user.uid).createUser(fullName, email);
      return true;


    } on FirebaseAuthException catch(error){
      print(error);
      return error;
    }

  }



}