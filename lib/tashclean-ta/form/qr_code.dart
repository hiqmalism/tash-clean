import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:tash_clean/tashclean-ta/form/nota.dart';
import 'package:intl/intl.dart';

class QRCode extends StatelessWidget {
  String? email;
  String? randomId;
  String? nama;
  String? no_hp;
  String? berat;
  String? alamat;
  String? selectedJasa;
  String? selectedPengiriman;
  String? selectedKategori;
  double subtotal;
  double totalJasa;
  double biayaPengiriman;
  DateTime tglMasuk;
  DateTime? tglKeluar;
  String? metodeBayar;
  String? status;
  String? keterangan;

  QRCode({
    this.email,
    required this.randomId,
    required this.nama,
    required this.no_hp,
    required this.berat,
    required this.alamat,
    required this.selectedJasa,
    required this.selectedPengiriman,
    required this.selectedKategori,
    required this.subtotal,
    required this.tglMasuk,
    required this.tglKeluar,
    required this.totalJasa,
    required this.biayaPengiriman,
    required this.status,
    required this.metodeBayar,
    required this.keterangan
  });

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fill,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Pembayaran',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: 400,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'TASH CLEAN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: primaryColor
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage('assets/icons/qr_code.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal\nRp. ${formatCurrency(subtotal)},-',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderNote(
                            email: email,
                            randomId: randomId,
                            nama: nama,
                            no_hp: no_hp,
                            berat: berat,
                            alamat: alamat,
                            selectedJasa: selectedJasa,
                            selectedPengiriman: selectedPengiriman,
                            selectedKategori: selectedKategori,
                            subtotal: subtotal,
                            tglMasuk: tglMasuk,
                            tglKeluar: tglKeluar,
                            totalJasa: totalJasa,
                            biayaPengiriman: biayaPengiriman,
                            status: status,
                            metodeBayar: metodeBayar,
                            keterangan: keterangan,
                          ),
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: Text('Selesai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


