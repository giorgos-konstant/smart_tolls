import 'package:flutter/material.dart';

class AdminOverview extends StatelessWidget {
  const AdminOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Overview Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Admin Overview Page'),
      ),
    );
  }
}