import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'salehomepage.dart'; //linegraph

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Charts',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SalesHomePage(),
      //home: LineHomePage(),//linegraph
    );
  }
}
