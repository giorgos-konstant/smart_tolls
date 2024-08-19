import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

Future<List<Transaction>?> getTotalTransactions() async {
  
  final url = Uri.parse('http://localhost:5000/total-stats/');
  Future<List<Transaction>?> transactions ;

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String,dynamic> data = jsonDecode(response.body);
      transactions = data['transactions'].map<Transaction>((item) => Transaction.fromJson(item)).toList();
      return transactions;
    }
    else {
      return null;
    }

  } catch (error) {
    return null;
  }
}

Future<TotalStatsPerToll?> getTotalStatsPerToll(String tollName) async {
  final url = Uri.parse('http://localhost:5000/total-stats');

  try {
    var reqBody = {'tollName' : tollName};
    final response = await http.post(
      url,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final Map<String,dynamic> data = jsonDecode(response.body);
      return TotalStatsPerToll.fromJson(data);
    }
    else {
      return null;
      }

  } catch (error) {
    return null;
  }
}