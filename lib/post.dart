import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'dart:developer';

Future<User?> loginUser(String username, String password) async {
  final url = Uri.parse('http://localhost:5000/login/');

  try {
    final response = await http.post(
      url,
      body: {'credentials': '$username,$password'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('Returned data:');
      print(data);
      return User.fromJson(data);
    } else {
      print('entered else');
      print(response.statusCode);
      return null;
    }
  } catch (error) {
    print("Exception: $error");
    return null;
  }
}

Future<User?> signUpUser(String username, String password, String valPwd,
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
      print(data);
      return User.fromJson(data);
    } else {
      log(response.body);
      return null;
    }
  } catch (error) {
    log("Exception: $error");
    return null;
  }
}

Future<ChargePolicy?> getPolicy() async {
  final url = Uri.parse('http://localhost:5000/charge-policy/');

  try {
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ChargePolicy.fromJson(data);
    } else {
      return null;
    }
  } catch (error) {
    print("Exception: $error");
    return null;
  }
}

Future<void> updateBalance(double amount, int userId) async {
  final url = Uri.parse('http://localhost:5000/add-money/');

  try {
    final response = await http.post(
      url,
      body: {
        'userId': userId,
        'amount': amount,
      },
    );

    if (response.statusCode == 200) {
      print("Balance updated.");
    }
  } catch (error) {
    print("Exception: $error");
  }
}
