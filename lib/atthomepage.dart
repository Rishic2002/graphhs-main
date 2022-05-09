// ignore_for_file: deprecated_member_use, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesHomePage extends StatefulWidget {
  @override
  _SalesHomePageState createState() {
    return _SalesHomePageState();
  }
}

class Sales {
  final int attVal;
  final String attmonth;
  final String colorVal;
  Sales(this.attVal, this.attmonth, this.colorVal);

  Sales.fromMap(Map<String, dynamic> map)
      : attVal = map['attVal'],
        colorVal = map['colorVal'],
        attmonth = map['attmonth'];

  @override
  String toString() => "Record<$attVal:$attmonth:$colorVal>";
}

class _SalesHomePageState extends State<SalesHomePage> {
  List<charts.Series<Sales, String>> _seriesBarData;
  List<Sales> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sales, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => sales.attmonth.toString(),
        measureFn: (Sales sales, _) => sales.attVal,
        colorFn: (Sales sales, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(sales.colorVal))),
        id: 'att',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.attmonth}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sales')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('att').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sales> sales = snapshot.data.docs
              .map((docsSnapshot) => Sales.fromMap(docsSnapshot.data()))
              .toList();
          return _buildChart(context, sales);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'ATTENDANCE',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
