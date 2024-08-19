import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:mqtt_client/mqtt_browser_client.dart';
import '../services/auth.dart';
// import '../services/mqtt.dart';
import '../widgets/admin_dashboard.dart';
import '../widgets/admin_transactions.dart';
import '../widgets/admin_current_policy.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    
    // final Future<MqttBrowserClient?> mqttbroker  = mqttBrokerSetUp(auth);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('EasyToll Admin'),
      ),
      bottomNavigationBar:
          SizedBox(height: 100, child: _buildNavigationBar(context)),
      body: _buildPage(auth),
    );
  }

  Widget _buildPage(AuthProvider auth) {
    switch (auth.currentIndex) {
      case 0:
        return AdminCurrentPolicy();
      case 1:
        return AdminDashboard();
      case 2:
        return AdminTransactions();
      default:
        return AdminDashboard();
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
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.space_dashboard, size: 35),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_rounded, size: 35),
          label: 'Overview',
        ),
      ],
    );
  }
}