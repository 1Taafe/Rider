import 'package:shared_preferences/shared_preferences.dart';

import '../Classes/User.dart';

class SharedPrefs{
  static Future<User> getUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User currentUser = User();
    currentUser.key = prefs.getString("user_key")!;
    currentUser.displayedName = prefs.getString("displayed_name")!;
    currentUser.role = prefs.getString("role")!;
    currentUser.phoneNumber = prefs.getString("phone_number")!;
    currentUser.username = prefs.getString("username")!;
    return currentUser;
  }

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_key", user.key);
    prefs.setString("displayed_name", user.displayedName);
    prefs.setString("role", user.role);
    prefs.setString("phone_number", user.phoneNumber);
    prefs.setString("username", user.username);
  }

  static Future<void> clearUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> isUserExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user_key")){
      return true;
    }
    else{
      return false;
    }
  }
}