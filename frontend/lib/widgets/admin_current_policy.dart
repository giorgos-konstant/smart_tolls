import 'package:flutter/material.dart';
import 'package:smart_tolls/models/models.dart';
import 'package:smart_tolls/services/auth.dart';
import 'package:provider/provider.dart';

class AdminCurrentPolicy extends StatelessWidget {
  const AdminCurrentPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);
    CurrentPolicy cp = auth.currentPolicy;
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
                    children: [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(
                          child: Container(
                              child: Text(cp.zoneCurrentPolicies[0].timeZone))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Akti Dymaion'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[0].regions[0].price}')))
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Perivola'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[0].regions[1].price}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Former TEI'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[0].regions[2].price}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Rio'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[0].regions[3].price}'))),
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
                    children: [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Container(child: Text('08:00-12:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Kon/poleos'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[1].regions[0].price}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Ag. Andreou'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[1].regions[1].price}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Germanou'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[1].regions[2].price}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Othonos-Amalias'))),
                      TableCell(
                          child: Container(
                              child: Text(
                                  '${cp.zoneCurrentPolicies[1].regions[3].price}'))),
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
