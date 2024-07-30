// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'auth.dart';
import 'post.dart';
import 'mqtt.dart';

void main() {
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider(), child: MyApp())
    ])
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartTolls',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

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
                ChargePolicy? chargePolicy = await getPolicy();

                if (user != null) {
                  auth.setUser(user);
                  auth.setChargePolicy(chargePolicy!);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  auth.loginMsg('Login Failed. Invalid username/password.');
                }
              },
              child: Text("Log In", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

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
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("Sign up Page", style: TextStyle(fontSize: 30)),
              SizedBox(height: 50),
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
                  labelText: 'Re-enter password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'e-mail adress',
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
              SizedBox(height: 20),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Sign Up', style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    
    final Future<MqttBrowserClient?> mqttbroker  = mqttBrokerSetUp(auth);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('EasyToll'),
      ),
      bottomNavigationBar:
          SizedBox(height: 100, child: _buildNavigationBar(context)),
      body: _buildPage(auth),
    );
  }

  Widget _buildPage(AuthProvider auth) {
    switch (auth.currentIndex) {
      case 0:
        return Policy();
      case 1:
        return Dashboard();
      case 2:
        return History();
      default:
        return Dashboard();
    }
  }

  Widget _buildNavigationBar(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    

    return BottomNavigationBar(
      currentIndex: auth.currentIndex,
      onTap: (index) {
        auth.setCurrentIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_exchange_rounded, size: 35),
          label: 'Charge Policy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.space_dashboard, size: 35),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history, size: 35),
          label: 'History',
        ),
      ],
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  Future<double?> _showAddBalanceDialog(BuildContext context) async {
    TextEditingController amountController = TextEditingController();
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    return showDialog<double>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Balance"),
            content: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Amount'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  double? amount = double.tryParse(amountController.text);
                  double? updatedBalance =
                      await updateBalance(amount as double, auth.user!.userId);
                  User updatedUser = User(
                      balance: updatedBalance as double,
                      userId: auth.user!.userId,
                      username: auth.user!.username,
                      email: auth.user!.email,
                      licensePlate: auth.user!.licensePlate,
                      deviceId: auth.user!.deviceId,
                      transactions: auth.user!.transactions);
                  auth.setUser(updatedUser);
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    double balance = auth.user!.balance;
    String balanceString = '${balance.toStringAsFixed(2)} EUR';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Remaining Balance:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              balanceString,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    double? amount = await _showAddBalanceDialog(context);
                    if (amount != null) {
                      await updateBalance(amount, auth.user!.userId);
                    }
                  },
                  icon: Icon(Icons.add, size: 50),
                  label: Text('Add Money', style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  icon: Icon(Icons.account_circle_rounded, size: 50),
                  label: Text('Profile', style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    ChargePolicy? cp = auth.chargePolicy;

    return Scaffold(
      appBar: AppBar(
        title: Text('Charge Policy'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Zone A',
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: const [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Center(child: Text('08:00-12:00'))),
                      TableCell(child: Center(child: Text('12:01-17:00'))),
                      TableCell(child: Center(child: Text('17:01-20:00'))),
                      TableCell(child: Center(child: Text('20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Akti Dymaion'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp!.zonePolicies[0].regions[0].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Perivola'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Former TEI'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Rio'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone4}'))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Zone B',
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: const [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Center(child: Text('08:00-12:00'))),
                      TableCell(child: Center(child: Text('12:01-17:00'))),
                      TableCell(child: Center(child: Text('17:01-20:00'))),
                      TableCell(child: Center(child: Text('20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Kon/poleos'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Ag. Andreou'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Germanou'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Othonos-Amalias'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone1}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone2}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone3}'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone4}'))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    

    List<Transaction> tr = auth.user!.transactions;

    return ListView.builder(
      itemCount: tr.length,
      itemBuilder: (context, index) {
        Transaction transaction = tr[index];

        return TransactionBox(transaction: transaction);
      },
    );
  }
}

class TransactionBox extends StatelessWidget {
  const TransactionBox({Key? key, required this.transaction}) : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Zone: ${transaction.zone}, Station: ${transaction.tollName}, Charge: ${transaction.chargeAmount}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Time: ${transaction.timeStamp}'),
        ],
      ),
    );
  }
}

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
              Text('Total transactions: $numTr',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
