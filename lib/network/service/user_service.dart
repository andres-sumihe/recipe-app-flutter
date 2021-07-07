import 'dart:convert';
import 'package:recipe_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jwt = prefs.getString('jwt');
    String apiUrl = 'http://192.168.11.210:8080/api/user/read.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{'jwt': jwt!}),
    );

    print(response.body);
    final data = jsonDecode(response.body);
    User? user = new User(email: data['response']['data']['email'], username: data['response']['data']['username']);
    user.email = data['response']['data']['email'];
    user.userId = int.parse(data['response']['data']['user_id']);
    user.username = data['response']['data']['username'];
    user.name = data['response']['data']['name'];
    user.pictureUrl = data['response']['data']['picture_url'];
    return user;
  }

  static Future<bool> updateUserPicture(String url) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    String apiUrl = 'http://192.168.11.210:8080/api/user/updateUserPhoto.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{'jwt': jwt!, 'picture_url': url}),
    );

    print(response.body);

    if(response.statusCode == 200 ){
      return true;
    }
      return false;
  }
}
