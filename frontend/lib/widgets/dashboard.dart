import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../models/models.dart';
import '../services/post_get.dart';
import 'user_profile.dart';

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
              decoration: InputDecoration(labelText: 'Enter Desired Amount'),
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
                      await updateBalance(auth,amount as double, auth.user!.userId);
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
        body: Container(
          decoration: BoxDecoration(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Remaining Balance:',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(Icons.account_balance_wallet_rounded,
                            size: 50)),
                    SizedBox(width: 30),
                    Text(
                      balanceString,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        double? amount = await _showAddBalanceDialog(context);
                        if (amount != null) {
                          await updateBalance(auth, amount, auth.user!.userId);
                        }
                      },
                      icon: Icon(Icons.add, size: 50),
                      label: Text('Update Balance',
                          style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile()));
                      },
                      icon: Icon(Icons.account_circle_rounded, size: 50),
                      label: Text('Profile', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
