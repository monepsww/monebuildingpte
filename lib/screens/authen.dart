import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monebuilding/models/user_model.dart';
import 'package:monebuilding/screens/my_service.dart';
import 'package:monebuilding/screens/register.dart';
import 'package:monebuilding/utility/my_style.dart';
import 'package:monebuilding/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;
  // Method

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().textColor)),
            prefixIcon: Icon(
              Icons.face,
              color: MyStyle().textColor,
            ),
            hintText: 'User : ',
            hintStyle: TextStyle(color: MyStyle().textColor)),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        // obscureText ปิดรหัส
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().textColor)),
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().textColor,
            ),
            hintText: 'Password : ',
            hintStyle: TextStyle(color: MyStyle().textColor)),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Mone Building !!',
      style: MyStyle().h1Main,
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        singInButton(),
        SizedBox(width: 5.0),
        singUpButton(),
      ],
    );
  }

  Widget singInButton() {
    return RaisedButton(
      color: MyStyle().textColor,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'ไม่ถูกต้อง', 'กรุณากรอกข้อมูลให้ถูกต้อง');
        } else {
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/pte/getUserWhereUserMone.php?isAdd=true&user=$user';

    Response response = await Dio().get(url);
    print('response = $response');
    if (response.toString() == 'null') {
      normalDialog(context, ' $user ไม่ถูกต้อง',
          'กรุณาตรวจสอบ ชื่อผู้ใช้ รหัสผ่าน ให้ถูกต้อง');
    } else {
      // แก้ไข โค้ดที่ value เป็นภาษาไทย
      var result = json.decode(response.data);
      print('result = $result');

      // วิธีส่งดาต้าทั้งก้อนไป แล้วให้โมเดลแยก
      for (var map in result) {
        UserModel userModel = UserModel.fromMap(map);
        if (password == userModel.password) {
          print('Welcome ${userModel.name}');

          // MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return My_service();});
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext buildContext) => My_service());
          //เขียน route แบบไม่มีการย้อนกลับ
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute,
              (Route<dynamic> route) {
            return false;
          });
        } else {
          normalDialog(context, 'ผิดพลาด', 'รหัสผ่านไม่ถูกต้อง');
        }
      }
    }
  }

  Widget singUpButton() {
    return OutlineButton(
      borderSide: BorderSide(color: MyStyle().textColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: MyStyle().textColor),
      ),
      onPressed: () {
        print('You Click Sign Up');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return Register();
        });
        // ไปแล้วสามารถ กดย้อนกลับได้
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(color: MyStyle().mainColor),
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().mainColor],
          radius: 2.0,
        )),
        child: Center(
          // child: showAppName(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                userForm(),
                passwordForm(),
                SizedBox(height: 10.0),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
