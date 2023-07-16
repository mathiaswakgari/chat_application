import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userKey = "userKey";
  static String userNameKey = "userNameKey";
  static String userEmailKey = "UserEmailKey";


  static Future<bool> saveUserLoggingStatus(bool isUserLoggedIn)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(userKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String email)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userEmailKey, email);
  }

  static Future<bool?> isUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userKey);
  }

  static Future<void> clearSharedPreferences() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

}