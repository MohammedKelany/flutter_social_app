import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreference;

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required key,
    required value,
  }) async {
    if (value is int) {
      return await sharedPreference!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreference!.setDouble(key, value);
    }
    if (value is String) {
      return await sharedPreference!.setString(key, value);
    }
    return await sharedPreference!.setBool(key, value);
  }

  static dynamic getData({required key}) {
    return sharedPreference?.get(key);
  }
  static Future<bool> clearAll()async{
    return await sharedPreference!.clear();
  }
  static Future<bool> remove(String key)async{
    return await sharedPreference!.remove(key);
  }
}
