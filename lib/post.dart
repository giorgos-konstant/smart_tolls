import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

Future<User?> loginUser(String username, String password) async {
  final url = Uri.parse('BACKEND_URL');

  try {
    final response = await http.post(
      url,
      body: {'credentials': '$username,$password'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      return null;
    }
  } catch (error) {
    print("Exception: $error");
    return null;
  }
}

Future<User?> signUpUser(String username, String password, String valPwd,
    String email, String licensePlate, int deviceId) async {
  final url = Uri.parse('BACKEND_URL');

  try {
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
        'valPassword': valPwd,
        'email': email,
        'licensePlate': licensePlate,
        'deviceId': deviceId
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      return null;
    }
  } catch (error) {
    print("Exception: $error");
    return null;
  }
}

Future<ChargePolicy?> getPolicy() async {
  final url = Uri.parse('BACKEND_URL');

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
  final url = Uri.parse('BACKEND_URL');

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
