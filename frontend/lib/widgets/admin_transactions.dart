import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/admin_post_get.dart';
import '../services/auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminTransactions extends StatelessWidget {
  const AdminTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);
    getTotalTransactions(auth);
    List<AdminTransaction> tr = auth.admin!.transactions;

    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions Overview'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: tr.length,
          itemBuilder: (context, index) {
            AdminTransaction transaction = tr[index];

            return TransactionBox(transaction: transaction);
          },
        ));
  }
}

class TransactionBox extends StatelessWidget {
  const TransactionBox({Key? key, required this.transaction}) : super(key: key);
  final AdminTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('User ID: ${transaction.userId}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Toll Entity: ${transaction.tollId}, Charge: ${transaction.chargeAmount}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Time: ${formatDate(transaction.timeStamp)}'),
        ],
      ),
    );
  }

  String? formatDate(String dateString) {
    DateTime isoDate = DateTime.parse(dateString);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy - HH:mm');
    String formattedDate = dateFormat.format(isoDate);

    return formattedDate;
  }
}
