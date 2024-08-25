import 'package:flutter/material.dart';
import 'package:smart_tolls/models/models.dart';
import 'package:smart_tolls/services/auth.dart';
import '../widgets/history.dart';
import 'package:provider/provider.dart';

class AdminTransactions extends StatelessWidget {
  const AdminTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);

    return ListView.builder(
      itemCount: auth.admin!.transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = auth.admin!.transactions[index];

        return TransactionBox(transaction: transaction);
      },
    );
  }
}
