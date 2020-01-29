import 'package:flutter/material.dart';
import 'package:monebuilding/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().barColor,
      ),
    );
  }
}
