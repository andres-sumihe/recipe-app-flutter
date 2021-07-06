import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {

  static Future<bool> loginWithEmailAndPassword(
      {String? email, String? password}) async {
    print("Ini Email dan Password : " + email! + password!);
    String apiUrl = 'http://192.168.11.210:8080/api/user/login.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(response.body);
    final data = jsonDecode(response.body);
    String jwtKey = data['jwt'];
    prefs.setString('jwt', jwtKey);
    return true;
  }
}
