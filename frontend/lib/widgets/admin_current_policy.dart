import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/admin_post_get.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';

class AdminCurrentPolicy extends StatelessWidget {
  const AdminCurrentPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider auth = Provider.of<AdminAuthProvider>(context);
    getCurrentPolicy(auth);
    CurrentPolicy cp = auth.currentPolicy;

    return Scaffold(
      appBar: AppBar(
        title: Text('Current Charge Policy'),
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
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange[400]!, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    ' Zone A  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromARGB(179, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 30),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Location'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Current Charge Amount'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Akti Dymaion'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[0].currentPrice}')))
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Perivola'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[1].currentPrice}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Former TEI'))),
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[2].currentPrice}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Rio'))),
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[3].currentPrice}'))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange[400]!, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    ' Zone B  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 30),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Location'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Current Charge Amount'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Kon/poleos'))),
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[4].currentPrice}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Ag. Andreou'))),
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[5].currentPrice}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Germanou'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[6].currentPrice}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              heightFactor: 2,
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  'Othonos-Amalias'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  '${cp.regionCurrentPolicies[7].currentPrice}'))),
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
