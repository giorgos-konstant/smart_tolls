import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_tolls/services/auth.dart';
import '../models/models.dart';

Future<bool?> loginAdmin(String username, String password) async {
  final url = Uri.parse('http://localhost:5000/admin/');

  try {
    var reqBody = {'username': username,'password':password};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      bool success = data['success'];
      return success;
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future getTotalTransactions(AdminAuthProvider auth) async {
  final url = Uri.parse('http://localhost:5000/admin-transactions/');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<AdminTransaction> transactions = data.map<AdminTransaction>((item) => AdminTransaction.fromJson(item)).toList();
      AdminUser updatedAdmin = AdminUser(
          transactions: transactions);
      auth.setAdmin(updatedAdmin);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future getTotalStatsPerToll(String tollName, AdminAuthProvider auth) async {
  final url = Uri.parse('http://localhost:5000/admin-map/');

  try {
    var reqBody = {'region': tollName, "timestamp" : DateTime.now().toIso8601String()};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      TotalStatsPerToll total = TotalStatsPerToll(
          totalTransactions: data['totalTransactions'],
          totalMoney: data['totalMoney'],
          currentPrice: data['currentPrice']);
      auth.setTotalStats(total);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<CurrentPolicy?> getCurrentPolicy() async {
  final url = Uri.parse('http://localhost:5000/admin-policy/');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return CurrentPolicy.fromJson(data);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}
