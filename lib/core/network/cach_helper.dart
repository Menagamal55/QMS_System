import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // الدالة دي بننادي عليها مرة واحدة بس في الـ main.dart
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // عشان نحفظ الداتا (زي التوكن والرول)
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return false;
  }

  // عشان نجيب الداتا
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // عشان نمسح الداتا (وقت تسجيل الخروج)
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}