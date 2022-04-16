// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'task.dart';

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() {
    return _TaskHomePageState();
  }
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<charts.Series<Task, String>> _seriesGaugeData;
  List<Task> mydata;
  _generateData(mydata) {
    _seriesGaugeData = List<charts.Series<Task, String>>();
    _seriesGaugeData.add(
      charts.Series(
        domainFn: (Task task, _) => task.taskDetails,
        measureFn: (Task task, _) => task.taskVal,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (Task row, _) => "${row.taskVal}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('task').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Task> task = snapshot.data.docs
              .map((docsSnapshot) => Task.fromMap(docsSnapshot.data()))
              .toList();
          return _buildChart(context, task);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Task> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
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
                child: charts.PieChart(_seriesGaugeData,
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
                        startAngle: 4 / 5 * pi,
                        arcLength: 7 / 5 * pi,
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
}
