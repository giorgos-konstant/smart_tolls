import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    List<Transaction> tr = auth.user!.transactions;

    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction History'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: tr.length,
          itemBuilder: (context, index) {
            Transaction transaction = tr[index];

            return TransactionBox(transaction: transaction);
          },
        ));
  }
}

class TransactionBox extends StatelessWidget {
  const TransactionBox({Key? key, required this.transaction}) : super(key: key);
  final Transaction transaction;

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
          Text(
            'Zone: ${transaction.zone[transaction.zone.length - 1]}, Station: ${transaction.tollName}, Charge: ${transaction.chargeAmount}',
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
