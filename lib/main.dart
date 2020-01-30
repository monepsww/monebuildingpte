import 'package:flutter/material.dart';
import 'package:monebuilding/screens/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.grey),
      home: Authen(),
    );
  }
}
