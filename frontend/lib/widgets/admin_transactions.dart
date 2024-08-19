import 'package:flutter/material.dart';

class AdminTransactions extends StatelessWidget {
  const AdminTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Transactions'),
      ),
    );
  }
}