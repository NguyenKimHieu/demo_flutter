import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  String _userName;
  String _password;
  bool _validate = false;
  bool isLoading = false;

  String get userName => _userName;

  String get password => _password;

  bool get validate => _validate;

  void setUserName(String val) {
    _userName = val;
    notifyListeners();
  }

  void setPassWord(String val) {
    _password = val;
    notifyListeners();
  }

  Future<void> validateInput() async {
    if (_userName != null && _userName != '' && password != null && password != '') {
      _validate = true;
    } else {
      _validate = false;
    }
    notifyListeners();
  }

  Future<void> resetLoadingState() async {
    await Future.delayed(Duration(seconds: 5), () {
      isLoading = false;
      notifyListeners();
    });
  }

  void pushLoading(){
    isLoading = true;
    notifyListeners();
  }
}
