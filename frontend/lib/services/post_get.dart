import 'dart:convert';
import 'dart:io';
import '../services/auth.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

Future<User?> loginUser(AuthProvider auth,String username, String password) async {
  final url = Uri.parse('http://localhost:5000/login/');

  try {
    var reqBody = {
      "username": username,
      "password": password,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      auth.setSessionToken(data['token']);
      return User.fromJson(data['userComplete']);
    } else {
      return null;
    }
  } catch (error) {
    print(error);
    return null;
  }
}

Future<User?> signUpUser(AuthProvider auth, String username, String password, String valPwd,
    String email, String licensePlate, String deviceId) async {
  final url = Uri.parse("http://localhost:5000/signup/");

  try {
    var reqBody = {
      "username": username,
      "password": password,
      "valPassword": valPwd,
      "email": email,
      "licensePlate": licensePlate,
      "deviceId": deviceId
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      auth.setSessionToken(data['token']);
      return User.fromJson(data['userWithDevice']);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<ChargePolicy?> getPolicy(AuthProvider auth) async {
  final url = Uri.parse('http://localhost:5000/charge-policy/');

  try {
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader: "Bearer ${auth.sessionToken}"});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return ChargePolicy.fromJson(data);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<double?> updateBalance(AuthProvider auth, double amount, String userId) async {
  final url = Uri.parse('http://localhost:5000/add-money/');

  try {
    var reqBody = {
      'userId': userId,
      'amount': amount,
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',HttpHeaders.authorizationHeader: "Bearer ${auth.sessionToken}"},
      body: jsonEncode(reqBody),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      double updatedBalance = json['balance'] as double;
      return updatedBalance;
    } else {
      return null;
    }
  } catch (error) {
    print("Error:");
    print(error);
    return null;
  }
}
