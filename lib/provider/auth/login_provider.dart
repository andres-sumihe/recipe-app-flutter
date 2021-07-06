import 'package:recipe_app/models/User.dart';
import 'package:recipe_app/network/service/login_service.dart';
import 'package:flutter/cupertino.dart';


class LoginProvider extends ChangeNotifier {
  bool loginStatus = false;
  bool get loginSuccess => loginStatus;

  void login(String email, String password) async {
    print(email + password);
    loginStatus = await LoginService.loginWithEmailAndPassword(email: email, password: password);

    notifyListeners();
  }
}