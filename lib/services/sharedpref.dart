import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  save(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, json.encode(value));
  }

  read() async {
  final prefs = await SharedPreferences.getInstance();
  return json.decode(prefs.getString('article')?? '');
  
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('article');
  }
}