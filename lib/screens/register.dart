import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monebuilding/utility/my_constant.dart';
import 'package:monebuilding/utility/my_style.dart';
import 'package:monebuilding/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  // File.io  input output เก็บรูปภาพเป็น temp ทั้งรูป
  File file;
  String name, user, password;
  // Method

  //เขียน Thred อัพโหลด ถ่ายภาพ
  Future<void> getPhoto(ImageSource imageSource) async {
    // เสี่ยงต่อการเออเร่อ or try catch
    try {
      //await สิ่งที่จะทำหลังจากนี้ ต้องทำ await ให้เสร็จก่อน
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

// ถ้าทำงานไปแล้ว ทำซ้ำ จะทำการ set ตัวเองใหม่เสมอ
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      iconSize: 50.0,
      icon: Icon(Icons.add_photo_alternate),
      onPressed: () {
        getPhoto(ImageSource.gallery);
      },
    );
  }

  Widget camaraButton() {
    return IconButton(
      iconSize: 50.0,
      icon: Icon(Icons.add_a_photo),
      onPressed: () {
        getPhoto(ImageSource.camera);
      },
    );
  }

  Widget passwordForm() {
    // ประกาศตัวแปรสี ไว้ใช้หลายที่
    Color color_password = Colors.redAccent;
    return Container(
      // ความห่างของ ซ้ายขวา
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        style: TextStyle(color: color_password),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color_password)),
          helperStyle: TextStyle(color: color_password),
          // คำอธิบายข้างล่าง
          helperText: 'Type Your Password in Blank',
          // ชื่อหัวข้อ
          labelText: 'Displayn Password : ',
          labelStyle: TextStyle(color: color_password),
          icon: Icon(
            Icons.account_circle,
            size: 36.0,
            color: color_password,
          ),
        ),
      ),
    );
  }

  Widget userForm() {
    // ประกาศตัวแปรสี ไว้ใช้หลายที่
    Color color_lightBlue = Colors.lightBlue;

    return Container(
      // ความห่างของ ซ้ายขวา
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        style: TextStyle(color: color_lightBlue),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color_lightBlue)),
          helperStyle: TextStyle(color: color_lightBlue),
          // คำอธิบายข้างล่าง
          helperText: 'Type Your User in Blank',
          // ชื่อหัวข้อ
          labelText: 'Displayn User : ',
          labelStyle: TextStyle(color: color_lightBlue),
          icon: Icon(
            Icons.account_circle,
            size: 36.0,
            color: color_lightBlue,
          ),
        ),
      ),
    );
  }

  Widget nameForm() {
    // ประกาศตัวแปรสี ไว้ใช้หลายที่
    Color color_blueAccent = Colors.blueAccent;

    return Container(
      // ความห่างของ ซ้ายขวา
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        style: TextStyle(color: color_blueAccent),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color_blueAccent)),
          helperStyle: TextStyle(color: color_blueAccent),
          // คำอธิบายข้างล่าง
          helperText: 'Type Your Name in Blank',
          // ชื่อหัวข้อ
          labelText: 'Displayn Name : ',
          labelStyle: TextStyle(color: color_blueAccent),
          icon: Icon(
            Icons.account_circle,
            size: 36.0,
            color: color_blueAccent,
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[camaraButton(), galleryButton()],
    );
  }

  Widget showAvatar() {
    return Container(
      // กำหนด panding ขอบเขตขอบรูปภาพ
      padding: EdgeInsets.all(20.0),
      // คำนวนว่าหน้าจอที่ใช้ขนาดเท่าไหร่
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      // Avatar
      child: file != null ? Image.file(file) : Image.asset('images/avatar.png'),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (file == null) {
          normalDialog(context, 'No Avtar', 'กรุณาเลือกตัว Avtar');
        } else if (name == null ||
            name.isEmpty ||
            user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'ไม่ถูกต้อง', 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          processUploadAvatar();
        }
      },
    );
  }

// Upload Image
  Future<void> processUploadAvatar() async {
    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, '$name.jpg');
      FormData formData = FormData.from(map);

      // ถ้าทำงานสำเสร็จจะ end ถ้าไม่จะไป catch
      await Dio()
          .post(MyConstant().urlAPIsaveFile, data: formData)
          .then((response) {
        print('response = $response');
        processInsertData();
      });
    } catch (e) {}
  }

// เพิ่มฐานข้อมูล
  Future<void> processInsertData() async {
    // path Image
    String avatar = 'https://www.androidthai.in.th/pte/avatarMone/$name.jpg';
    // path Data
    String url =
        'https://www.androidthai.in.th/pte/addUserMone.php?isAdd=true&name=$name&user=$user&password=$password&avatar=$avatar';

    await Dio().get(url).then((response) {
      if (response.toString() == 'true') {
        // มาจากไหน กลับไปตรงนั้น ถอยหลังกลับ 1 ครั้ง เหมือน กดปุ่มกลับ บนมุมซ้าย
        Navigator.of(context).pop();
      } else {
        normalDialog(context, 'Error', 'Again Please');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[registerButton()],
        backgroundColor: MyStyle().barColor,
      ),
      body: ListView(
        children: <Widget>[
          showAvatar(),
          showButton(),
          nameForm(),
          userForm(),
          passwordForm(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
