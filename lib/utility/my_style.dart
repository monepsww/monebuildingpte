import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyle {
  Color textColor = Color.fromARGB(0xff, 0x00, 0x96, 0x24);
  Color mainColor = Color.fromARGB(0xff, 0x00, 0x00, 0x00);
  Color barColor = Color.fromARGB(0xae, 0xae, 0xae, 0xae);

  TextStyle h1Main = GoogleFonts.sacramento(
    textStyle: TextStyle(
      fontSize: 30.0,
      color: Color.fromARGB(0xff, 0x00, 0x96, 0x24),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
  );

  MyStyle();
}
