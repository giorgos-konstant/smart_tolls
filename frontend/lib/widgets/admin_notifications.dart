import 'package:flutter/material.dart';

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Notifications'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Admin Notifications'),
      ),
    );
  }
}