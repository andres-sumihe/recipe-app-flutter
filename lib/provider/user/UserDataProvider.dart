import 'package:recipe_app/models/User.dart';
import 'package:recipe_app/network/service/user_service.dart';
import 'package:flutter/cupertino.dart';


class UserDataProvider extends ChangeNotifier {
  User? userData;
  User? get getData => userData;

  void getUserData() async {
    userData = await UserService.getUserData();

    notifyListeners();
  }
}