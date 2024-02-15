import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TashClean',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Login(),
    );
  }
}