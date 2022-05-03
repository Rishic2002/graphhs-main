// ignore_for_file: deprecated_member_use, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ATTHomePage extends StatefulWidget {
  @override
  _ATTHomePageState createState() {
    return _ATTHomePageState();
  }
}

class Att {
  final int Present;
  final DateTime date;
 
  Att(this.Present, this.date);

  Att.fromMap(Map<String, Timestamp > map)
      : Present = map['Present'],
        

       date = map['date'];

 
 
}

class _ATTHomePageState extends State<ATTHomePage> {
  List<charts.Series<Att, int>> _seriesLineData;
  List<Att> mydata;
  _generateData(mydata) {
    //data being stored
    _seriesLineData = List<charts.Series<Att, int>>();
    _seriesLineData.add(
      charts.Series(
        domainFn: (Att ATTENDANCE, _) => ATTENDANCE.Present,
        measureFn: (Att ATTENDANCE, _) => ATTENDANCE.date,
       
        id: 'ATTENDANCE',
        data: mydata,
        labelAccessorFn: (Att row, _) => "${row.attMonth}", //xaxis
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WELCOME')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ATTENDANCE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Att> ATTENDANCE = snapshot.data.docs
              .map((docsSnapshot) => Att.fromMap(docsSnapshot.data()))
              .toList();
          return _buildChart(context, ATTENDANCE);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Att> Attdata) {
    mydata = Attdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'ATTENDANCE BY MONTH',
                style: TextStyle(fontSize: 24.0, fontFamily: 'RobotoMono'),
              ),
              SizedBox(
                  width: 900,
                  height: 400,
                  child: Card(
                    child: Expanded(
                      child: charts.LineChart(
                        _seriesLineData,
                        animate: true,
                        defaultRenderer:
                            new charts.LineRendererConfig(includePoints: true),
                        //POINTS
                        animationDuration:
                            Duration(seconds: 5), //DURATION OF ANIMATION
                        behaviors: [
                          new charts.SeriesLegend(
                            position: charts.BehaviorPosition.end,
                            outsideJustification:
                                charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding:
                                new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.Color(r: 127, g: 63, b: 191),
                                fontFamily: 'Georgia',
                                fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

/*
//GAUGE
class Percent {
  final int taskVal;
  final String taskDetails;
  final String colorVal;
  Percent(this.taskDetails, this.taskVal, this.colorVal);

  Percent.fromMap(Map<String, dynamic> map)
      : 
        taskDetails = map['taskdetails'],
        taskVal = map['taskVal'],
        colorVal = map['colorVal'];

  @override
  String toString() => "Record<$taskVal:$taskDetails>";
}

class ATTHomePageState extends State<ATTHomePage> {
  List<charts.Series<Percent, String>> _seriesPieData;
  List<Percent> mydata;
  _generateGaugeData(myGaugedata) {
    _seriesPieData = List<charts.Series<Percent, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Percent percent, _) => Percent.taskDetails,
        measureFn: (Percent percent, _) => Percent.taskVal,
        colorFn: (Percent percent, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(percent.colorVal))),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (Percent row, _) => "${row.taskVal}",
      ),
    );
  }

 
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Percent').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Percent> Percent = snapshot.data.docs
              .map((docsSnapshot) => Percent.fromMap(docsSnapshot.data()))
              .toList();
          return _buildGauge(context, Percent);
        }
      },
    );
  }

  /*Widget _buildChart(BuildContext context, List<Percent> Gaugedata) {
    myGaugedata = taskdata;
    _generateData(myGaugedata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Time spent on daily tasks',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding: new EdgeInsets.only(
                            right: 4.0, bottom: 4.0, top: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
*/
