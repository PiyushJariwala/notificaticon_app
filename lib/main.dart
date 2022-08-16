import 'package:flutter/material.dart';
import 'package:notificaticon_app/screen/homescreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Homepage(),
      },
    ),
  );
}
