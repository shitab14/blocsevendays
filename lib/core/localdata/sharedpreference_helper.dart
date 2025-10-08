import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<void> setValue<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception('Unsupported data type for SharedPreferences');
    }
  }

  static Future<T?> getValue<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception('Unsupported data type for SharedPreferences');
    }
  }

  static Future<bool> removeValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}