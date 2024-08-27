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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Icon(Icons.account_circle_rounded, size: 200)),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: [
                    SizedBox(height: 50),
                    Text('User ID:', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Username:', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Email:', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('License Plate:', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Total transactions:', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Device ID:', style: TextStyle(fontSize: 20)),
                  ]),
                  Column(children: [
                    SizedBox(height: 50),
                    Text('$userId', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('$username', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('$email', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('$lp', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('$numTr', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('$deviceId', style: TextStyle(fontSize: 20)),
                  ])
                ])
          ],
        ),
      ),
    );
  }
}
