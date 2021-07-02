import 'package:flutter/cupertino.dart';

class HomeController with ChangeNotifier {
  bool buttonSelected = true;

  void changeButton(bool value) {
    buttonSelected = value;
    notifyListeners();
  }
}
