

import 'package:shared_preferences/shared_preferences.dart';
import '../enums/shared_preferences_keys.dart';

class SharedPreferencesManger {
  late SharedPreferences _preferences;
  static SharedPreferencesManger? _instance;

  SharedPreferencesManger._() {
    initSharedPreferences();
  }

  Future <void> initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferencesManger get instance {
    _instance ??= SharedPreferencesManger._();
    return _instance!;
  }

  void setList(SharedPreferencesKeys key, List<String> value) {
    if (value.isNotEmpty) {
      _preferences.setStringList(key.value, value.map((e) => e.toString()).toList());
    }
  }

  List<String>? getList(SharedPreferencesKeys key) {
    List<String>? stringList = _preferences.getStringList(key.value);
    return stringList;
  }

  void setString(SharedPreferencesKeys key, String? value) {
    if (value != null && value.isNotEmpty) {
      _preferences.setString(key.value, value);
    }else{
      remove(key);
    }
  }

  void setInt(SharedPreferencesKeys key, int value) {
    if (value != 0) {
      _preferences.setInt(key.value, value);
    }
  }

  void setBool(SharedPreferencesKeys key, bool value) {
    _preferences.setBool(key.value, value);
  }

  String? getString(SharedPreferencesKeys key) {
    String? value = _preferences.getString(key.value);
    return value;
  }

  int? getInt(SharedPreferencesKeys key) {
    int? value = _preferences.getInt(key.value);
    return value;
  }

  bool? getBool(SharedPreferencesKeys key) {
    bool? value = _preferences.getBool(key.value);
    return value;
  }

  Future<void> remove(SharedPreferencesKeys key) async {
    await _preferences.remove(key.value);
  }

  Future<void> clearLocale() async {
    await _preferences.clear();
  }
}
