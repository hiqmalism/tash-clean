import 'package:flutter/material.dart';
import 'package:tash_clean/form/checkout/struk.dart';
import 'package:tash_clean/login.dart';
import 'package:tash_clean/screens/bottom_nav.dart';
import 'package:tash_clean/screens/persediaan.dart';
import 'package:tash_clean/screens/pesanan.dart';

void main() {
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      title: 'Tash Clean',
      home: Login()
    );
  }
}
