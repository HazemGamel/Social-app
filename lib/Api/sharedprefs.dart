import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  static Future savetoken(String token)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('token', token);
   // preferences.setString('myId', myId);
    //preferences.setInt('myId', myId);
  }
}