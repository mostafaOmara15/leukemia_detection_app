import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setBoolean(String key, bool value) async{
    return await sharedPreferences?.setBool(key, value);
  }

  static bool? getBoolean(String key){
    return sharedPreferences?.getBool(key);
  }

  static Future setString(String key, String value) async{
    return await sharedPreferences?.setString(key, value);
  }

  static String? getString(String key){
    return sharedPreferences?.getString(key);
  }

  static Future setInt(String key, int value) async{
    return await sharedPreferences?.setInt(key, value);
  }

  static int? getInt(String key){
    return sharedPreferences?.getInt(key);
  }
}