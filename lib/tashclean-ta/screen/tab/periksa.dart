import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class MyPeriksa extends StatelessWidget {
  final String periksaBar;
  final VoidCallback onTap; // Callback function for when the menu is tapped

  const MyPeriksa({Key? key, required this.periksaBar, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: InkWell(
        splashColor: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          onTap();
          if (periksaBar == 'Persediaan') {
            Navigator.pushNamed(context, '/persediaan');
          } else if (periksaBar == 'riwayat') {
            Navigator.pushNamed(context, '/riwayat');
          }
        },
        child: Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              periksaBar,
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}