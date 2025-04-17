import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("_keyUserId", userId);
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("_keyUserId");
}


Future<bool> saveFirstEnter(bool value) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setBool("ProductAlign", value);
}

Future<bool?> getFirstEnter() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool("ProductAlign");
}
