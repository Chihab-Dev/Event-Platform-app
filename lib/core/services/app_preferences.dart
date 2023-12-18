import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";
const String PREFS_KEY_USER_LOGGED_IN = "PREFS_KEY_USER_LOGGED_IN";

class AppPrefrences {
  final SharedPreferences _sharedPreferences;

  AppPrefrences(this._sharedPreferences);

  // user id

  void setUserId(String userId) {
    _sharedPreferences.setString(PREFS_KEY_USER_ID, userId);
  }

  String? getUserId() {
    return _sharedPreferences.getString(PREFS_KEY_USER_ID);
  }

  Future<void> removeUserId() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_ID);
  }

  // User logged in

  void setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN) ?? false;
  }

  Future<void> removeUserLoggedIn() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_LOGGED_IN);
  }
}
