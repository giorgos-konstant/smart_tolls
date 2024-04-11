import 'package:flutter/material.dart';
import 'models.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  ChargePolicy? _chargePolicy;
  ChargePolicy? get chargePolicy => _chargePolicy;

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  String _loginFailMsg = '';
  String get loginFailMsg => _loginFailMsg;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setChargePolicy(ChargePolicy chargePolicy) {
    _chargePolicy = chargePolicy;
    notifyListeners();
  }

  void loginMsg(String msg) {
    _loginFailMsg = loginFailMsg;
    notifyListeners();
  }
}
