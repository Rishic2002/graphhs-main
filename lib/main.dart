import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'atthomepage.dart';
import 'firebase_options.dart'; //linegraph

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: ATTHomePage(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

