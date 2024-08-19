import 'package:flutter/material.dart';

class AdminCurrentPolicy extends StatelessWidget {
  const AdminCurrentPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Policy'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Current Policy'),
      ),
    );
  }
}