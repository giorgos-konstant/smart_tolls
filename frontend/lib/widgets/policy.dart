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
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange[400]!, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    ' Zone A  ',
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
                                  style: TextStyle(fontSize: 15), 'Location'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '08:00-12:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '12:01-17:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '17:01-20:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  'Akti Dymaion'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp!, 0, 0, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 0, 0, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 0, 0, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 0, 0, 4)!),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15), 'Perivola'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 0, 1, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 0, 1, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 0, 1, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 0, 1, 4)!)
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  'Former TEI'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 0, 2, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 0, 2, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 0, 2, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 0, 2, 4)!),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child:
                                  Text(style: TextStyle(fontSize: 15), 'Rio'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 0, 3, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 0, 3, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 0, 3, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 0, 3, 4)!),
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
                                  style: TextStyle(fontSize: 15), 'Location'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '08:00-12:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '12:01-17:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '17:01-20:00'))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.blueGrey[700]!,
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  '20:01-22:00'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  'Kon/poleos'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 1, 0, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 1, 0, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 1, 0, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 1, 0, 4)!),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  'Ag. Andreou'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 1, 1, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 1, 1, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 1, 1, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 1, 1, 4)!),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15), 'Germanou'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 1, 2, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 1, 2, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 1, 2, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 1, 2, 4)!),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                                  style: TextStyle(fontSize: 15),
                                  'Othonos-Amalias'))),
                      TableCell(
                          child: cellContent(0, currentZone, cp, 1, 3, 1)!),
                      TableCell(
                          child: cellContent(1, currentZone, cp, 1, 3, 2)!),
                      TableCell(
                          child: cellContent(2, currentZone, cp, 1, 3, 3)!),
                      TableCell(
                          child: cellContent(3, currentZone, cp, 1, 3, 4)!),
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
    int curZone = 4;
    int zone1Start = 8;
    int zone1End = 12;
    int zone2End = 17;
    int zone3End = 20;
    int zone4End = 22;
    int curHour = now.hour;

    if (curHour >= zone1Start && curHour < zone1End) {
      curZone = 0;
    } else if (curHour >= zone1End && curHour < zone2End) {
      curZone = 1;
    } else if (curHour >= zone2End && curHour < zone3End) {
      curZone = 2;
    } else if (curHour >= zone3End && curHour < zone4End) {
      curZone = 3;
    }
    return curZone;
  }

  Color _getColor(int row, int zone) {
    if (row == zone) {
      return Colors.blueGrey[600]!;
    } else {
      return Colors.transparent;
    }
  }

  Container? cellContent(int row, int currentZone, ChargePolicy cp, int zone,
      int region, int timeZone) {
    if (timeZone == 1) {
      return Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: _getColor(row, currentZone),
          child: Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '${cp.zonePolicies[zone].regions[region].prices.timeZone1}'));
    }
    if (timeZone == 2) {
      return Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: _getColor(row, currentZone),
          child: Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '${cp.zonePolicies[zone].regions[region].prices.timeZone2}'));
    }
    if (timeZone == 3) {
      return Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: _getColor(row, currentZone),
          child: Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '${cp.zonePolicies[zone].regions[region].prices.timeZone3}'));
    }
    if (timeZone == 4) {
      return Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: _getColor(row, currentZone),
          child: Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '${cp.zonePolicies[zone].regions[region].prices.timeZone4}'));
    } else {
      return null;
    }
  }
}
