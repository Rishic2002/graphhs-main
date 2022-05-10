// ignore_for_file: deprecated_member_use

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
  final int month;
  final int present;
  final String name;
  Att(this.month, this.present, this.name);

  Att.fromMap(Map<String, dynamic> map)
      : month = map['month'],
        name = map['name'],
        present = map['present'];

  @override
  String toString() => "Record<$name>";
}

class _ATTHomePageState extends State<ATTHomePage> {
  List<charts.Series<Att, int>> _seriesLineData;
  List<Att> mydata;
  _generateData(mydata) {
    //data being stored
    _seriesLineData = List<charts.Series<Att, int>>();
    _seriesLineData.add(
      charts.Series(
        domainFn: (Att att, _) => att.month,
        measureFn: (Att att, _) => att.present,
        id: 'att',
        data: mydata,
        labelAccessorFn: (Att row, _) => "${row.month}", //xaxis
      ),
    );
  }

  Stream<QuerySnapshot> getGraphSnapshots(BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection('abc')
        .doc('CrWQ7xDo9eh9rR1SujpB')
        .collection('attendance')
        .where('month', isLessThanOrEqualTo: 9)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getGraphSnapshots(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Att> att = snapshot.data.docs
              .map((docsSnapshot) => Att.fromMap(docsSnapshot.data()))
              .toList();
          return _buildChart(context, att);
        }
      },
    );
  }

  @override
  Widget _buildChart(BuildContext context, List<Att> Attdata) {
    mydata = Attdata;
    _generateData(mydata);
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  text: "9M",
                  icon: new Icon(Icons.bookmark),
                ),
                Tab(
                  icon: new Icon(Icons.bookmark),
                ),
                Tab(
                  icon: new Icon(Icons.bookmark),
                ),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'att BY MONTH',
                          style: TextStyle(
                              fontSize: 24.0, fontFamily: 'RobotoMono'),
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
                                      new charts.LineRendererConfig(
                                          includePoints: true),
                                  //POINTS
                                  animationDuration: Duration(
                                      seconds: 5), //DURATION OF ANIMATION
                                  behaviors: [
                                    new charts.SeriesLegend(
                                      position: charts.BehaviorPosition.end,
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                      horizontalFirst: false,
                                      desiredMaxRows: 2,
                                      cellPadding: new EdgeInsets.only(
                                          right: 4.0, bottom: 4.0),
                                      entryTextStyle: charts.TextStyleSpec(
                                          color: charts.Color(
                                              r: 127, g: 63, b: 191),
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
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'att BY MONTH',
                          style: TextStyle(
                              fontSize: 24.0, fontFamily: 'RobotoMono'),
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
                                      new charts.LineRendererConfig(
                                          includePoints: true),
                                  //POINTS
                                  animationDuration: Duration(
                                      seconds: 5), //DURATION OF ANIMATION
                                  behaviors: [
                                    new charts.SeriesLegend(
                                      position: charts.BehaviorPosition.end,
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                      horizontalFirst: false,
                                      desiredMaxRows: 2,
                                      cellPadding: new EdgeInsets.only(
                                          right: 4.0, bottom: 4.0),
                                      entryTextStyle: charts.TextStyleSpec(
                                          color: charts.Color(
                                              r: 127, g: 63, b: 191),
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
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'att BY MONTH',
                          style: TextStyle(
                              fontSize: 24.0, fontFamily: 'RobotoMono'),
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
                                      new charts.LineRendererConfig(
                                          includePoints: true),
                                  //POINTS
                                  animationDuration: Duration(
                                      seconds: 5), //DURATION OF ANIMATION
                                  behaviors: [
                                    new charts.SeriesLegend(
                                      position: charts.BehaviorPosition.end,
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                      horizontalFirst: false,
                                      desiredMaxRows: 2,
                                      cellPadding: new EdgeInsets.only(
                                          right: 4.0, bottom: 4.0),
                                      entryTextStyle: charts.TextStyleSpec(
                                          color: charts.Color(
                                              r: 127, g: 63, b: 191),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
