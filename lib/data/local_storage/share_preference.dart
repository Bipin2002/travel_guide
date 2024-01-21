import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future writedata({required String text}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('text', text);
  }

  Future<String> readdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString('text');
    return data!;
  }

  Future clear({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
 
  
}
