import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../models/models.dart';
import '../services/post_get.dart';
import 'homepage.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController valPasswordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController licensePlateController = TextEditingController();
    TextEditingController deviceIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          title: Text("Sign Up", style: TextStyle(fontSize: 25)),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 250, right: 250, top: 200, bottom: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: valPasswordController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Validate password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Adress',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: licensePlateController,
                decoration: InputDecoration(
                  labelText: 'Vehicle License Plate',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: deviceIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NFC Device ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              Text(auth.loginFailMsg,
                  style: TextStyle(color: Colors.red, fontSize: 20)),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    String valPwd = valPasswordController.text;
                    String email = emailController.text;
                    String licensePlate = licensePlateController.text;
                    String deviceId = deviceIdController.text;

                    User? user = await signUpUser(username, password, valPwd,
                        email, licensePlate, deviceId);
                    auth.setUser(user!);
                    ChargePolicy? chargePolicy = await getPolicy();
                    auth.setChargePolicy(chargePolicy!);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      auth.loginMsg('Sign Up failed. Please the credentials.');
                    }
                  },
                  child: Text('Sign Up', style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
    );
  }
}
