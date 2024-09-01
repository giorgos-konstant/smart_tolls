import 'dart:core';
import 'package:flutter/material.dart';
import '../models/models.dart';

class AdminAuthProvider extends ChangeNotifier {
  AdminUser? _admin;
  AdminUser? get admin => _admin;

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  String _loginFailMsg = '';
  String get loginFailMsg => _loginFailMsg;

  TotalStatsPerToll _total =
      TotalStatsPerToll(totalTransactions: 0, totalMoney: 0.0, currentPrice: 0.0);
  TotalStatsPerToll get total => _total;

  CurrentPolicy _currentPolicy = CurrentPolicy(regionCurrentPolicies: []);
  CurrentPolicy get currentPolicy => _currentPolicy;

  // ignore: prefer_final_fields
  String _sessionToken = '';
  String get sessionToken => _sessionToken;

  void setSessionToken(String jwt){
    _sessionToken = jwt;
    notifyListeners();
  }

  void setAdmin(AdminUser newAdmin) {
    _admin = newAdmin;
    notifyListeners();
  }

  void clearUser() {
    _admin = null;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void loginMsg(String msg) {
    _loginFailMsg = msg;
    notifyListeners();
  }

  void setTotalStats(TotalStatsPerToll total) {
    _total = total;
    notifyListeners();
  }

  void setCurPolicy(CurrentPolicy policy) {
    _currentPolicy = policy;
    notifyListeners();
  }
}

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  ChargePolicy? _chargePolicy;
  ChargePolicy? get chargePolicy => _chargePolicy;

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  String _loginFailMsg = '';
  String get loginFailMsg => _loginFailMsg;

  String _sessionToken = '';
  String get sessionToken => _sessionToken;

  void setSessionToken(String jwt){
    _sessionToken = jwt;
    notifyListeners();
  }

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
    _loginFailMsg = msg;
    notifyListeners();
  }
}
