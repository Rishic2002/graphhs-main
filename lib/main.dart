import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'taskhomepage.dart'; //pie chart
//bargraph

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Chart',
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      home: TaskHomePage(), //gauge
    );
  }
}
