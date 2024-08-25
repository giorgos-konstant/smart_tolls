import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tolls/services/admin_post_get.dart';
import '../services/auth.dart';
import '../models/models.dart';
import '../services/post_get.dart';
import 'admin_page.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(auth.loginFailMsg,
                style: TextStyle(color: Colors.red, fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;
                User? user = await loginUser(username, password);
                CurrentPolicy? chargePolicy = await getCurrentPolicy();

                if (user != null) {
                  auth.setUser(user);
                  auth.setCurPolicy(chargePolicy!);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPage()));
                } else {
                  auth.loginMsg('Login Failed. Invalid username/password.');
                }
              },
              child: Text("Log In", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
