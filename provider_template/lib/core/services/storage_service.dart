import 'dart:convert';

import 'package:juno_provider_base_project/config/config.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final Logger _logger = FlavorConfig.instance.logger;

  final SharedPreferences sharedPreferences;

  StorageService({required this.sharedPreferences});

  Future<bool> setInt(String key, int value) async =>
      await sharedPreferences.setInt(key, value);

  Future<bool> setDouble(String key, double value) async =>
      await sharedPreferences.setDouble(key, value);

  Future<bool> setString(String key, String value) async =>
      await sharedPreferences.setString(key, value);

  Future<bool> setBool(String key, bool value) async =>
      await sharedPreferences.setBool(key, value);

  int? getInt(String key) => sharedPreferences.getInt(key) ?? 0;

  double? getDouble(String key) => sharedPreferences.getDouble(key) ?? 0.0;

  Future<bool> setStringList(String key, List<String> value) async =>
      await sharedPreferences.setStringList(key, value);

  String? getString(String key) => sharedPreferences.getString(key) ?? '';

  bool? getBool(String key) => sharedPreferences.getBool(key) ?? false;

  List<String>? getStringList(String key) =>
      sharedPreferences.getStringList(key) ?? [];

  bool containsKey(String key) => sharedPreferences.containsKey(key);

  Future<bool> remove(String key) async => await sharedPreferences.remove(key);

  Future<bool> clear() async => await sharedPreferences.clear();

  /// save as json string
  Future<bool> setObject(String key, Object object) async {
    String jsonString = '';
    bool result = false;
    try {
      jsonString = json.encode(object);
      result = await sharedPreferences.setString(key, jsonString);
    } catch (e) {
      _logger.e(e.toString());
    }

    return result;
  }

  /// Read the json string
  Object getObject(String key) {
    final String jsonString = sharedPreferences.getString(key) ?? '';
    Object object = {};
    if (jsonString.isNotEmpty) {
      try {
        object = json.decode(jsonString) ?? {};
      } catch (e) {
        _logger.e(e.toString());
      }
    }

    return object;
  }
}
