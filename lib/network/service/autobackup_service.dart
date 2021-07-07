import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AutobackupService {

  static Future<bool> backup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jwt = prefs.getString('jwt');
    print("Ini Email dan Password : " + jwt!);
    String apiUrl = 'http://192.168.11.210:8080/api/utils/autobackup.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{'jwt': jwt}),
    );

    if(response.statusCode == 200){
      return true;
    }
    return false;
  }
}
