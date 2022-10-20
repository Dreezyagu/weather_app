import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  StorageHelper._();

  static late SharedPreferences _prefs;

  static Future<SharedPreferences> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future<List<String>?> getStringList(String key) async {
    await _getInstance();
    return _prefs.getStringList(key);
  }

  static void setStringList(String key, List<String>? value) async {
    if (key.isEmpty || value!.isEmpty) return;
    final SharedPreferences preferences = await (_getInstance());
    preferences.setStringList(key, value);
  }

  static void remove(String key) async {
    if (key.isEmpty) return;
    final SharedPreferences preferences = await (_getInstance());
    if (preferences.containsKey(key)) {
      preferences.remove(key);
    }
  }

  static Future<bool> clearPreferences() async {
    final SharedPreferences preferences = await (_getInstance());
    return await preferences.clear();
  }
}
