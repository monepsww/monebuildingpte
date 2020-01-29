import 'package:flutter/material.dart';
import 'package:monebuilding/screens/register.dart';
import 'package:monebuilding/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field

  // Method

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
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
      onPressed: () {},
    );
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
        MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return Register();});
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
