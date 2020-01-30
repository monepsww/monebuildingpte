import 'package:flutter/material.dart';
import 'package:monebuilding/widget/list_building.dart';

class My_service extends StatefulWidget {
  @override
  _My_serviceState createState() => _My_serviceState();
}

class _My_serviceState extends State<My_service> {
  // Field
  //หน้า widget ที่ใช้เรียกไปหน้าอื่นๆ 
  Widget currentWidget = ListBuilding();

  // Method
  // showDrawer คือปุ่มด้านซ้านเปิดปิดเมนู ในโทรศัพท์
  Widget showDrawer() {
    return Drawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }
}
