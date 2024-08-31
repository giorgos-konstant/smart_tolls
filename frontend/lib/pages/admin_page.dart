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
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);

    // final Future<MqttBrowserClient?> mqttbroker  = mqttBrokerSetUp(auth);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('GridFlow Admin'),
      ),
      bottomNavigationBar:
          SizedBox(height: 100, child: _buildNavigationBar(context)),
      body: _buildPage(auth),
    );
  }

  Widget _buildPage(AdminAuthProvider auth) {
    switch (auth.currentIndex) {
      case 0:
        return AdminCurrentPolicy();
      case 1:
        return AdminMap();
      case 2:
        return AdminTransactions();
      default:
        return AdminMap();
    }
  }

  Widget _buildNavigationBar(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);

    return BottomNavigationBar(
      currentIndex: auth.currentIndex,
      onTap: (index) {
        auth.setCurrentIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_exchange_rounded, size: 35),
          label: 'Policy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place_outlined, size: 35),
          label: 'Map Overview',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined, size: 35),
          label: 'Transactions',
        ),
      ],
    );
  }
}
