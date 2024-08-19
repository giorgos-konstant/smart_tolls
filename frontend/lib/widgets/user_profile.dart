import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    

    String userId = auth.user!.userId;
    String username = auth.user!.username;
    String email = auth.user!.email;
    String lp = auth.user!.licensePlate;
    int numTr = auth.user!.transactions.length;
    String deviceId = auth.user!.deviceId;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.all(5),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text('User ID: $userId', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('Username: $username', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('Email: $email', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('License Plate: $lp', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('Total transactions: $numTr',style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('Device ID: $deviceId',style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}