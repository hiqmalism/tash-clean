import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/form/qr_code.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:intl/intl.dart';
import 'package:tash_clean/tashclean-ta/form/nota.dart';

class Checkout extends StatefulWidget {
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

  Checkout({
    this.email,
    required this.nama,
    required this.no_hp,
    required this.berat,
    required this.alamat,
    required this.selectedJasa,
    required this.selectedPengiriman,
    required this.selectedKategori,
    required this.subtotal,
    required this.randomId,
    required this.tglMasuk,
    required this.tglKeluar,
    required this.totalJasa,
    required this.biayaPengiriman,
  });

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? _metodeBayar;
  String? _status;
  String? keterangan = 'antrian';

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  void changeStatus() {
    if ((_metodeBayar == 'qris') || (_metodeBayar == 'tunai')) {
      _status = 'lunas';
      sendPostRequest(context);
    } else if (_metodeBayar == 'bayarnanti') {
      _status = 'menunggu';
      sendPostRequest(context);
    }
  }

  Future<void> sendPostRequest(BuildContext context) async {
    print(widget.selectedPengiriman);
    if (_metodeBayar == 'qris') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QRCode(
              email: widget.email,
              randomId: widget.randomId,
              nama: widget.nama,
              no_hp: widget.no_hp,
              berat: widget.berat,
              alamat: widget.alamat,
              selectedJasa: widget.selectedJasa,
              selectedPengiriman: widget.selectedPengiriman,
              selectedKategori: widget.selectedKategori,
              subtotal: widget.subtotal,
              tglMasuk: widget.tglMasuk,
              tglKeluar: widget.tglKeluar,
              totalJasa: widget.totalJasa,
              biayaPengiriman: widget.biayaPengiriman,
              status: _status,
              metodeBayar: _metodeBayar,
              keterangan: keterangan,
            ),
        )
      );
    } else if (_metodeBayar == 'tunai') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderNote(
              email: widget.email,
              randomId: widget.randomId,
              nama: widget.nama,
              no_hp: widget.no_hp,
              berat: widget.berat,
              alamat: widget.alamat,
              selectedJasa: widget.selectedJasa,
              selectedPengiriman: widget.selectedPengiriman,
              selectedKategori: widget.selectedKategori,
              subtotal: widget.subtotal,
              tglMasuk: widget.tglMasuk,
              tglKeluar: widget.tglKeluar,
              totalJasa: widget.totalJasa,
              biayaPengiriman: widget.biayaPengiriman,
              status: _status,
              metodeBayar: _metodeBayar,
              keterangan: keterangan,
            ),
          )
      );
    } else if (_metodeBayar == 'bayarnanti') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderNote(
              email: widget.email,
              randomId: widget.randomId,
              nama: widget.nama,
              no_hp: widget.no_hp,
              berat: widget.berat,
              alamat: widget.alamat,
              selectedJasa: widget.selectedJasa,
              selectedPengiriman: widget.selectedPengiriman,
              selectedKategori: widget.selectedKategori,
              subtotal: widget.subtotal,
              tglMasuk: widget.tglMasuk,
              tglKeluar: widget.tglKeluar,
              totalJasa: widget.totalJasa,
              biayaPengiriman: widget.biayaPengiriman,
              status: _status,
              metodeBayar: _metodeBayar,
              keterangan: keterangan,
            ),
          )
        );
      }
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.fill,
        ),
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
              fontSize: 16,
            ),
          ),
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: MyForm(),
        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal\nRp. ${formatCurrency(widget.subtotal)},-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    changeStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Selesai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget MyForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilihan Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    MetodePembayaran('Qris', 'qris', 'assets/icons/qris_white.jpg'),
                    MetodePembayaran('Tunai', 'tunai', 'assets/icons/cash_black.png'),
                    MetodePembayaran('Bayar Nanti', 'bayarnanti', 'assets/icons/credit_black.png')
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Harga',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Jasa',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        'Rp. ${formatCurrency(widget.totalJasa)},-',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Pengiriman',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        'Rp. ${formatCurrency(widget.biayaPengiriman)},-',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Rp. ${formatCurrency(widget.subtotal)},-',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget MetodePembayaran(String text, String value, String img) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (_metodeBayar == value) ? BorderRadius.circular(10) : null,
            border: (_metodeBayar == value)
                ? Border.all(style: BorderStyle.solid, width: 2, color: primaryColor)
                : null,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _metodeBayar = (_metodeBayar == value) ? null : value;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage(img),
                  width: 60,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}