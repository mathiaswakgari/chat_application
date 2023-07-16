import 'package:chat_application/helper/functions.dart';
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
      return error.message;
    }

  }

  Future signIn(String email, String password) async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).user!;
      return true;
    } on FirebaseAuthException catch (error){
      return error.message;
    }
  }

  Future signOut() async{
    try{
      await HelperFunctions.saveUserLoggingStatus(false);
      await HelperFunctions.saveUserName("");
      await HelperFunctions.saveUserEmail("email");
      await firebaseAuth.signOut();
    }
    catch(error){
      return null;
    }
  }
}