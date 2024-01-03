// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
            if (!_isAuth)
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

  bool _isValidLP = false;

  void _validateVehicle(String? value) {
    if (value == null || !RegExp(r'^[A-Z]{3}-\d{4}$').hasMatch(value)) {
      _isValidLP = false;
    } else {
      _isValidLP = true;
    }
  }

  void _validateSignUp() {
    _validateVehicle(_vehicleController.text);
    if (_passwordController.text == _validatePwdController.text && _isValidLP) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => MyHomePage(title: 'SmartTolls'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Sign Up'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Username"),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Enter username"),
            ),
            SizedBox(height: 16.0),
            Text("Password"),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Enter password"),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Text("Validate Password"),
            TextField(
              controller: _validatePwdController,
              decoration: InputDecoration(hintText: "Re-enter password"),
            ),
            // if (_passwordController.text != _validatePwdController.text)
            //   Text('Password validation failed',
            //       style: TextStyle(color: Colors.red)),
            SizedBox(height: 16.0),
            Text("E-mail Adress"),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Enter e-mail"),
            ),
            SizedBox(height: 16.0),
            Text("Vehicle"),
            TextField(
              controller: _vehicleController,
              decoration: InputDecoration(hintText: "Enter plate number"),
            ),
            // if (!_isValidLP)
            //   Text('Invalid License Plate. Please enter a valid license plate.',
            //       style: TextStyle(color: Colors.red)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateSignUp,
              child: Text('Sign Up'),
            )
          ],
        ),
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
  DateTime selectedDay = DateTime.now();
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
      bottomNavigationBar: _buildNavigationBar(),
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
      selectedIndex: _currentIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.currency_exchange_rounded),
          label: 'Charge Policy',
        ),
        NavigationDestination(
          icon: Icon(Icons.space_dashboard),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }

  Widget dashboard() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Large Text
          const Text(
            'Remaining Balance:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '0.00 EUR',
            style: TextStyle(fontSize: 20),
          ),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add Button
              IconButton(
                onPressed: () {
                  // Add button functionality
                },
                icon: const Icon(Icons.add),
                tooltip: 'Add',
                iconSize: 60,
              ),

              // Check Account Button
              IconButton(
                onPressed: () {
                  // Check Account button functionality
                },
                icon: const Icon(Icons.account_circle),
                tooltip: 'Check Account',
                iconSize: 60,
              ),
            ],
          ),

          // Payment History
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Column(
              children: [
                Text(
                  'Payment 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Payment info as main text',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Column(
              children: [
                Text(
                  'Payment 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Payment info as main text',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chargePolicy() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge Policy'),
      ),
      body: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          children: const [
            // Table Headers
            TableRow(
              children: [
                TableCell(child: Center(child: Text('Location'))),
                TableCell(child: Center(child: Text('Morning'))),
                TableCell(child: Center(child: Text('Evening'))),
                TableCell(child: Center(child: Text('Noon'))),
                TableCell(child: Center(child: Text('Night'))),
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
      ),
    );
  }

  Widget history() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Payment History
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment 1
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Payment 1',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Payment info as text for Payment 1',
                    style: TextStyle(fontSize: 16),
                  ),

                  // Payment 2
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Payment 2',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Payment info as text for Payment 2',
                    style: TextStyle(fontSize: 16),
                  ),

                  // Payment 3
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Payment 3',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Payment info as text for Payment 3',
                    style: TextStyle(fontSize: 16),
                  ),

                  // Payment 4
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Payment 4',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Payment info as text for Payment 4',
                    style: TextStyle(fontSize: 16),
                  ),

                  // Payment 5
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Payment 5',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Payment info as text for Payment 5',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
