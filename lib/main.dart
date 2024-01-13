// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'models.dart';
import 'auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => AuthProvider(), child: MyApp()),
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              User user = User(
                isAuth: true,
                userId: 1,
                username: 'sample_user',
                balance: 100.0,
                email: 'user@mail.com',
                licensePlate: 'ABC-1234',
                transactions: [
                  Transaction(
                      userId: 1,
                      zone: 'A',
                      tollName: "Former TEI",
                      timeStamp: DateTime.now(),
                      chargeAmount: 0.70),
                  Transaction(
                      userId: 1,
                      zone: "B",
                      tollName: "Germanou",
                      timeStamp: DateTime.now(),
                      chargeAmount: 0.35)
                ],
              );
              auth.setUser(user);
              ChargePolicy chargePolicy = ChargePolicy(
                aktiDymaion1: 0.1,
                aktiDymaion2: 0.2,
                aktiDymaion3: 0.3,
                aktiDymaion4: 0.4,
                perivola1: 1.1,
                perivola2: 1.2,
                perivola3: 1.3,
                perivola4: 1.4,
                tei1: 2.1,
                tei2: 2.2,
                tei3: 2.3,
                tei4: 2.4,
                rio1: 3.1,
                rio2: 3.2,
                rio3: 3.3,
                rio4: 3.4,
                konpoleos1: 4.1,
                konpoleos2: 4.2,
                konpoleos3: 4.3,
                konpoleos4: 4.4,
                agandreou1: 5.1,
                agandreou2: 5.2,
                agandreou3: 5.3,
                agandreou4: 5.4,
                germanou1: 6.1,
                germanou2: 6.2,
                germanou3: 6.3,
                germanou4: 6.4,
                othamal1: 7.1,
                othamal2: 7.2,
                othamal3: 7.3,
                othamal4: 7.4,
              );
              auth.setChargePolicy(chargePolicy);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("Log In"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              User user = User(
                isAuth: true,
                userId: 2,
                username: 'new_user',
                email: 'newuser@mail.com',
                licensePlate: 'TKH-4768',
                balance: 40.00,
                transactions: [
                  Transaction(
                      userId: 2,
                      zone: 'A',
                      tollName: "Rio",
                      timeStamp: DateTime.now(),
                      chargeAmount: 0.70),
                  Transaction(
                      userId: 2,
                      zone: "B",
                      tollName: "Othonos Amalias",
                      timeStamp: DateTime.now(),
                      chargeAmount: 0.35)
                ],
              );
              auth.setUser(user);
              ChargePolicy chargePolicy = ChargePolicy(
                aktiDymaion1: 0.1,
                aktiDymaion2: 0.2,
                aktiDymaion3: 0.3,
                aktiDymaion4: 0.4,
                perivola1: 1.1,
                perivola2: 1.2,
                perivola3: 1.3,
                perivola4: 1.4,
                tei1: 2.1,
                tei2: 2.2,
                tei3: 2.3,
                tei4: 2.4,
                rio1: 3.1,
                rio2: 3.2,
                rio3: 3.3,
                rio4: 3.4,
                konpoleos1: 4.1,
                konpoleos2: 4.2,
                konpoleos3: 4.3,
                konpoleos4: 4.4,
                agandreou1: 5.1,
                agandreou2: 5.2,
                agandreou3: 5.3,
                agandreou4: 5.4,
                germanou1: 6.1,
                germanou2: 6.2,
                germanou3: 6.3,
                germanou4: 6.4,
                othamal1: 7.1,
                othamal2: 7.2,
                othamal3: 7.3,
                othamal4: 7.4,
              );
              auth.setChargePolicy(chargePolicy);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('Sign Up')),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('EasyToll'),
        automaticallyImplyLeading: true,
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          double amount = 0.00;
                          return AlertDialog(
                            title: Text('Add Money'),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    amount = double.tryParse(value) ?? 0.0;
                                  },
                                );
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  balance += amount;
                                  Navigator.of(context).pop();
                                },
                                child: Text('Add'),
                              ),
                            ],
                          );
                        });
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
                          child: Center(child: Text('${cp?.aktiDymaion1}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.aktiDymaion2}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.aktiDymaion3}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.aktiDymaion4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Perivola'))),
                      TableCell(child: Center(child: Text('${cp?.perivola1}'))),
                      TableCell(child: Center(child: Text('${cp?.perivola2}'))),
                      TableCell(child: Center(child: Text('${cp?.perivola3}'))),
                      TableCell(child: Center(child: Text('${cp?.perivola4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Former TEI'))),
                      TableCell(child: Center(child: Text('${cp?.tei1}'))),
                      TableCell(child: Center(child: Text('${cp?.tei2}'))),
                      TableCell(child: Center(child: Text('${cp?.tei3}'))),
                      TableCell(child: Center(child: Text('${cp?.tei4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Rio'))),
                      TableCell(child: Center(child: Text('${cp?.rio1}'))),
                      TableCell(child: Center(child: Text('${cp?.rio2}'))),
                      TableCell(child: Center(child: Text('${cp?.rio3}'))),
                      TableCell(child: Center(child: Text('${cp?.rio4}'))),
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
                          child: Center(child: Text('${cp?.konpoleos1}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.konpoleos2}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.konpoleos3}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.konpoleos4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Ag. Andreou'))),
                      TableCell(
                          child: Center(child: Text('${cp?.agandreou1}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.agandreou2}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.agandreou3}'))),
                      TableCell(
                          child: Center(child: Text('${cp?.agandreou4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Germanou'))),
                      TableCell(child: Center(child: Text('${cp?.germanou1}'))),
                      TableCell(child: Center(child: Text('${cp?.germanou2}'))),
                      TableCell(child: Center(child: Text('${cp?.germanou3}'))),
                      TableCell(child: Center(child: Text('${cp?.germanou4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Othonos-Amalias'))),
                      TableCell(child: Center(child: Text('${cp?.othamal1}'))),
                      TableCell(child: Center(child: Text('${cp?.othamal2}'))),
                      TableCell(child: Center(child: Text('${cp?.othamal3}'))),
                      TableCell(child: Center(child: Text('${cp?.othamal4}'))),
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
