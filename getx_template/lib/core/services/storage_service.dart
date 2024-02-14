import 'dart:convert';

import 'package:get/get.dart';
import 'package:juno_getx_base_project/config/config.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  final Logger _logger = FlavorConfig.instance.logger;

  /// Internal plugin singleton initialization
  late final SharedPreferences _spInstance;

  /// Specific initialization method
  Future<StorageService> init() async {
    _spInstance = await SharedPreferences.getInstance();

    return this;
  }

  Future<bool> setInt(String key, int value) async =>
      await _spInstance.setInt(key, value);

  Future<bool> setDouble(String key, double value) async =>
      await _spInstance.setDouble(key, value);

  Future<bool> setString(String key, String value) async =>
      await _spInstance.setString(key, value);

  Future<bool> setBool(String key, bool value) async =>
      await _spInstance.setBool(key, value);

  int? getInt(String key) => _spInstance.getInt(key) ?? 0;

  double? getDouble(String key) => _spInstance.getDouble(key) ?? 0.0;

  Future<bool> setStringList(String key, List<String> value) async =>
      await _spInstance.setStringList(key, value);

  String? getString(String key) => _spInstance.getString(key) ?? '';

  bool? getBool(String key) => _spInstance.getBool(key) ?? false;

  List<String>? getStringList(String key) =>
      _spInstance.getStringList(key) ?? [];

  bool containsKey(String key) => _spInstance.containsKey(key);

  Future<bool> remove(String key) async => await _spInstance.remove(key);

  Future<bool> clear() async => await _spInstance.clear();

  /// save as json string
  Future<bool> setObject(String key, Object object) async {
    String jsonString = '';
    bool result = false;
    try {
      jsonString = json.encode(object);
      result = await _spInstance.setString(key, jsonString);
    } catch (e) {
      _logger.e(e.toString());
    }

    return result;
  }

  /// Read the json string
  Object getObject(String key) {
    final String jsonString = _spInstance.getString(key) ?? '';
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
