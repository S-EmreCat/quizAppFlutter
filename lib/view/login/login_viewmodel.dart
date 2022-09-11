import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  String? nickName;

  void getNickName(String nick) {
    nickName = nick;
    notifyListeners();
  }
}
