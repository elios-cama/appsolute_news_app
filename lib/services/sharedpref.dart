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
  setListData(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<List<String>?> getListData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}