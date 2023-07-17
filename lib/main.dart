import 'package:chat_application/helper/functions.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/home_screen.dart';
import 'package:chat_application/screens/login_screen.dart';
import 'package:chat_application/screens/signup_screen.dart';
import 'package:chat_application/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId
    ));
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserStatus();
  }

  getUserStatus()async{
    await HelperFunctions.isUserLoggedIn().then(
            (value) {
              if(value != null){
                setState(() {
                  _isLoggedIn = value;
                });
              }
            });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatNovo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isLoggedIn ?  const HomeScreen() : const LoginScreen(),
      // home: ChatScreen(),
    );
  }
}

