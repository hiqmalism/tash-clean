import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class MyStatus extends StatelessWidget {
  final String statusBar;
  final VoidCallback onTap; // Callback function for when the menu is tapped

  const MyStatus({Key? key, required this.statusBar, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: secondaryColor,
        onTap: () {
          onTap();
          if (statusBar == 'Antrian') {
            Navigator.pushNamed(context, '/antrian');
          } else if (statusBar == 'Proses') {
            Navigator.pushNamed(context, '/proses');
          } else if (statusBar == 'Siap Ambil') {
            Navigator.pushNamed(context, '/siap_ambil');
          } else if (statusBar == 'Selesai') {
            Navigator.pushNamed(context, '/selesai');
          }
        },
        child: Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              statusBar,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ),
    );
  }
}

