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

    DateTime now = DateTime.now();
    int currentZone = getCurrentZone(now);


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
                      TableCell(child: Container (
                        color: _getColor(0,currentZone),child: Text('08:00-12:00'))),
                      TableCell(child: Container (
                        color: _getColor(1,currentZone),child: Text('12:01-17:00'))),
                      TableCell(child: Container (
                        color: _getColor(2,currentZone),child: Text('17:01-20:00'))),
                      TableCell(child: Container (
                        color: _getColor(3,currentZone),child: Text('20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Akti Dymaion'))),
                      TableCell(
                          child: Container(
                              color: _getColor(0,currentZone),
                              child: Text(
                                  '${cp!.zonePolicies[0].regions[0].prices.timeZone1}'))),
                      TableCell(
                          child: Container(
                              color: _getColor(1,currentZone),
                              child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[0].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Perivola'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[1].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Former TEI'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[2].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Rio'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[0].regions[3].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
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
                    children: [
                      TableCell(child: Center(child: Text('Location'))),
                      TableCell(child: Container (
                        color: _getColor(0,currentZone),child: Text('08:00-12:00'))),
                      TableCell(child: Container (
                        color: _getColor(1,currentZone),child: Text('12:01-17:00'))),
                      TableCell(child: Container (
                        color: _getColor(2,currentZone),child: Text('17:01-20:00'))),
                      TableCell(child: Container (
                        color: _getColor(3,currentZone),child: Text('20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Kon/poleos'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[0].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Ag. Andreou'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[1].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Germanou'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[2].prices.timeZone4}'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Othonos-Amalias'))),
                      TableCell(
                          child: Container( color: _getColor(0,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone1}'))),
                      TableCell(
                          child: Container( color: _getColor(1,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone2}'))),
                      TableCell(
                          child: Container( color: _getColor(2,currentZone),child: Text(
                                  '${cp.zonePolicies[1].regions[3].prices.timeZone3}'))),
                      TableCell(
                          child: Container( color: _getColor(3,currentZone),child: Text(
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

  int getCurrentZone(DateTime now) {

    int curZone = 0;
    int zone1Start = 8;
    int zone1End = 12;
    int zone2End = 17;
    int zone3End = 20;
    int zone4End = 22;
    int curHour = 21;//now.hour;

    if (curHour >= zone1Start && curHour < zone1End) {
      curZone =  0;
    }
    else if (curHour >= zone1End && curHour < zone2End) {
      curZone =  1;
    }
    else if (curHour >= zone1End && curHour < zone2End) {
      curZone =  2;
    }else if (curHour >= zone3End && curHour < zone4End) {
      curZone =  3;
    }
    return curZone;
  }

  Color _getColor(int row, int zone) {
    if (row == zone) {
      return Colors.green;
    }
    else {
      return Colors.white;
    }
  }
}