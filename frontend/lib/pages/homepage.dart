import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../services/mqtt.dart';
import '../widgets/dashboard.dart';
import '../widgets/policy.dart';
import '../widgets/history.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    String clientName = 'subscribe-${1000}}';
    mqttBrokerSetUp(auth, clientName);

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
