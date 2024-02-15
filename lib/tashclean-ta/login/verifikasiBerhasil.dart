import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/login/login.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class Verifikasi extends StatefulWidget {
  Verifikasi({Key? key}) : super(key: key);

  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
  @override
  void initState() {
    super.initState();

    // Use a Timer to navigate to the login page after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Login(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutQuart;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ta3.png', width: 90.0, height: 90.0, fit: BoxFit.fill),
            const SizedBox(height: 15.0),
            Text(
              'VERIFIKASI',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Selamat verifikasi yang anda\nlakukan berhasil, silahkan\nlanjut untuk masuk',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
