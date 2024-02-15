import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/form/form_pesanan.dart';
import 'package:tash_clean/keuangan/form/pengeluaran.dart';
import 'package:tash_clean/style.dart';

class TambahKeuangan extends StatelessWidget {
  const TambahKeuangan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                splashColor: secondaryColor,
                leading: Icon(
                  CupertinoIcons.arrow_up,
                  color: successColor,
                ),
                title: Text(
                  'Tambah Pemasukan',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderForm()
                      )
                  );
                },
              ),
            ),
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                splashColor: secondaryColor,
                leading: Icon(
                  CupertinoIcons.arrow_down,
                  color: errorColor,
                ),
                title: Text(
                  'Tambah Pengeluaran',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Pengeluaran()
                      )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
