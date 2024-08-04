import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../models/models.dart';

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