import 'package:shared_preferences/shared_preferences.dart';

class SessionManeger {
  //set data into shared preferences like this

  static Future<void> saveDetailes(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);

  }

//get value from shared preferences
  static Future<String?> getDetails(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static logoutSP() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
