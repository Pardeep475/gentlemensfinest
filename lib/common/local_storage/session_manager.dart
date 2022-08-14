import 'package:shared_preferences/shared_preferences.dart';

import '../../network/modal/login_api_response.dart';
import '../app_strings.dart';
import 'storage_strings.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() {
    return _sessionManager;
  }

  SessionManager._internal();

  static final Future<SharedPreferences> _pref =
      SharedPreferences.getInstance();

  static void setLogin(bool isLogin) {
    _pref.then((value) => value.setBool(StorageStrings.isLogin, isLogin));
  }

  static Future<bool> isLogin() {
    return _pref
        .then((value) => value.getBool(StorageStrings.isLogin) ?? false);
  }

  static void setLanguage(String language) {
    _pref.then(
        (value) => value.setString(StorageStrings.setUpLanguage, language));
  }

  static Future<String?> getLanguage() {
    return _pref.then(
        (value) => value.getString(StorageStrings.setUpLanguage));
  }


  //  USER_DATA
  static void setUserData(Escort userData) async {
    _pref.then((value) => value.setString(
        AppStrings.userData, escortResponseToJson(userData)));
  }

  static Future<String?> getUserData() {
    return _pref.then((value) => value.getString(AppStrings.userData));
  }

  static clearAllData() async {
    String? language = await getLanguage();
    _pref.then((value) => value.clear());
    if(language != null){
      setLanguage(language);
    }

  }
}
