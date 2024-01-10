// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
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
      home: const LoginSignUpScreen(),
    );
  }
}

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isAuth = false;

  void _authUser() {
    setState(() {
      _isAuth = (_usernameController.text == 'admin' &&
          _passwordController.text == 'admin');
      if (_isAuth) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'SmartTolls'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login/Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text('Username'),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your username',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text('Password'),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (!_isAuth &&
                (_usernameController.text.isNotEmpty ||
                    _passwordController.text.isNotEmpty))
              Text(
                'Invalid username/password',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _authUser,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //auth logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _validatePwdController = TextEditingController();
  final _emailController = TextEditingController();
  final _vehicleController = TextEditingController();

  String _passwordFailString = '';
  String _lpFailString = '';
  String _emailFailString = '';

  void _validateSignUp() {
    bool validPassword =
        (_passwordController.text == _validatePwdController.text);
    bool validLP =
        RegExp(r'^[A-Z]{3}-\d{4}$').hasMatch(_vehicleController.text);
    bool validEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController.text);

    if (validPassword && validLP && validEmail) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => MyHomePage(title: 'SmartTolls'))));
    }
    if (!validPassword) {
      setState(() {
        _passwordFailString = 'Password Validation Failed';
      });
    } else {
      setState(() {
        _passwordFailString = '';
      });
    }
    if (!validLP) {
      setState(() {
        _lpFailString = 'Invalid License Plate.';
      });
    } else {
      setState(() {
        _lpFailString = '';
      });
    }
    if (!validEmail) {
      setState(() {
        _emailFailString = 'Invalid E-mail Format.';
      });
    } else {
      setState(() {
        _emailFailString = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Sign Up'),
      ),
      body: Column(
        children: [
          Text("Username"),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Enter username"),
          ),
          SizedBox(height: 5.0),
          Text("Password"),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(hintText: "Enter password"),
            obscureText: true,
          ),
          SizedBox(height: 5.0),
          Text("Validate Password"),
          TextField(
            controller: _validatePwdController,
            decoration: InputDecoration(hintText: "Re-enter password"),
          ),
          Text(_passwordFailString, style: TextStyle(color: Colors.red)),
          SizedBox(height: 5.0),
          Text("E-mail Adress"),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "Enter e-mail"),
          ),
          Text(_emailFailString, style: TextStyle(color: Colors.red)),
          SizedBox(height: 5.0),
          Text("Vehicle"),
          TextField(
            controller: _vehicleController,
            decoration: InputDecoration(hintText: "Enter plate number"),
          ),
          Text(_lpFailString, style: TextStyle(color: Colors.red)),
          SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: _validateSignUp,
            child: Text('Sign Up'),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  double balance = 0.00;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: SizedBox(height: 100, child: _buildNavigationBar()),
      body: <Widget>[
        chargePolicy(),
        dashboard(),
        history(),
      ][_currentIndex],
    );
  }

  Widget _buildNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      indicatorColor: Colors.grey,
      indicatorShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      selectedIndex: _currentIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.currency_exchange_rounded, size: 35),
          label: 'Charge Policy',
        ),
        NavigationDestination(
          icon: Icon(Icons.space_dashboard, size: 35),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.history, size: 35),
          label: 'History',
        ),
      ],
    );
  }

  StatefulWidget dashboard() {
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
                                    setState(() {
                                      amount = double.tryParse(value) ?? 0.0;
                                    });
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
                                  setState(() {
                                    balance += amount;
                                  });
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
                        MaterialPageRoute(builder: (context) => userProfile()));
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

  Widget chargePolicy() {
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
                children: const [
                  // Table Headers
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Center(child: Text('08:00-12:00'))),
                      TableCell(child: Center(child: Text('12:01-17:00'))),
                      TableCell(child: Center(child: Text('17:01-20:00'))),
                      TableCell(child: Center(child: Text('20:01-22:00'))),
                    ],
                  ),

                  // Table Rows
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Akti Dymaion'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Perivola'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Former TEI'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Rio'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
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
                children: const [
                  // Table Headers
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Center(child: Text('08:00-12:00'))),
                      TableCell(child: Center(child: Text('12:01-17:00'))),
                      TableCell(child: Center(child: Text('17:01-20:00'))),
                      TableCell(child: Center(child: Text('20:01-22:00'))),
                    ],
                  ),

                  // Table Rows
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Kon/poleos'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Ag. Andreou'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Germanou'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Othonos-Amalias'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
                      TableCell(child: Center(child: Text('0.00'))),
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

  Widget history() {
    return Column(
      children: [
        SizedBox(height: 10),
        Text('Payment History', style: TextStyle(fontSize: 22)),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment $index',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Text('info for payment $index',
                          style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget userProfile() {
    const String username = 'admin';
    const String email = 'example@mail.com';
    const String vehicleInfo = 'XYZ-0000';

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
            children: const [
              SizedBox(height: 30),
              Text('Username: $username', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('Email: $email', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text('License Plate: $vehicleInfo',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
