import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userKey = "";
  static String userName = "";
  static String userEmail = "";

  static Future<bool?> isUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userKey);
  }

}