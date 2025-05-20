import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferences sharedPreferences;

  /// Initialize SharedPreferences instance (must call before use)
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save a raw string value
  static Future<void> save(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  /// Read a raw string value
  static Future<String?> read(String key) async {
    return sharedPreferences.getString(key);
  }

  /// Save a JSON-serializable object
  static Future<void> saveObject<T>(
      String key,
      T value,
      Map<String, dynamic> Function(T) toJson,
      ) async {
    final jsonString = json.encode(toJson(value));
    await sharedPreferences.setString(key, jsonString);
  }

  /// Read a JSON-serializable object
  static Future<T?> readObject<T>(
      String key,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return fromJson(jsonMap);
  }
  /// Clear all stored data
  static Future<void> clear() async {
    await sharedPreferences.clear();
  }
  /// Remove a value by key
  static Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
