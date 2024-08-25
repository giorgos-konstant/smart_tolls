import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_tolls/services/auth.dart';
import '../models/models.dart';

Future getTotalTransactions(AdminAuthProvider auth) async {
  final url = Uri.parse('http://localhost:5000/total-transactions/');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<Transaction> transactions = data['transactions']
          .map<Transaction>((item) => Transaction.fromJson(item))
          .toList();
      User updatedAdmin = User(
          balance: 0,
          userId: 'admin',
          username: 'admin',
          email: 'admin@mail.com',
          licensePlate: 'XXX-0000',
          deviceId: '1',
          transactions: transactions);
      auth.setUser(updatedAdmin);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future getTotalStatsPerToll(String tollName, AdminAuthProvider auth) async {
  final url = Uri.parse('http://localhost:5000/total-stats/');

  try {
    var reqBody = {'tollName': tollName};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      TotalStatsPerToll _total = TotalStatsPerToll(
          totalTransactions: data['totalTransactions'],
          totalMoney: data['totalMoney']);
      auth.setTotalStats(_total);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<CurrentPolicy?> getCurrentPolicy() async {
  final url = Uri.parse('http://localhost:5000/admin-current-policy/');

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
