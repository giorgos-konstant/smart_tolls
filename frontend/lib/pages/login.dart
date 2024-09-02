import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../models/models.dart';
import '../services/mqtt.dart';
import '../services/post_get.dart';
import 'homepage.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
          centerTitle: true,
        ),
        body: Container(
          height: 700,
          padding: EdgeInsets.only(right: 250, left: 250, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/text_logo_black_bg.png',
                  width: 500, height: 200),
              SizedBox(height: 30),
              TextField(
                style: TextStyle(fontSize: 20),
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(fontSize: 20),
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
                  User? user = await loginUser(auth, username, password);
                  ChargePolicy? chargePolicy = await getPolicy(auth);

                  if (user != null) {
                    auth.setUser(user);
                    auth.setChargePolicy(chargePolicy!);
                    mqttBrokerSetUp(auth, 'subscribe-1000');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    auth.loginMsg('Login Failed. Invalid username/password.');
                  }
                },
                child: Text("Log In", style: TextStyle(fontSize: 25)),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text('Sign Up', style: TextStyle(fontSize: 15)),
                  ),
                ],
              )

              // SizedBox(height: 30),
            ],
          ),
        ));
  }
}
