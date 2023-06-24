import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPreference {
  static Future<SharedPreferences> get _instance async =>
      prefInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefInstance = await _instance;
    return prefInstance!;
  }

  static String getString(String key, [String? defValue]) {
    return prefInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> clearPreferences() {
    return prefInstance!.clear();
  }
}
