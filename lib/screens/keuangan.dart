import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tash_clean/form/profil.dart';
import 'package:tash_clean/keuangan/filter_sheet.dart';
import 'package:tash_clean/keuangan/tambah_keuangan.dart';
import 'package:tash_clean/style.dart';

// void main() {
//   runApp(Keuangan());
// }

class Keuangan extends StatefulWidget {
  String? email;
  Keuangan({super.key, this.email});

  @override
  State<Keuangan> createState() => _KeuanganState();
}

class _KeuanganState extends State<Keuangan> {

  Future<List<dynamic>> fetchData(String? status) async {
    final response = await http.get(
      Uri.parse('http://localhost/api/tashclean/readtransaksi.php?'),
    );

    if (response.statusCode == 200) {
      print(widget.email);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            'assets/images/Tash_2.png',
          ),
        ),
        leadingWidth: 120,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyProfile()
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(
                  CupertinoIcons.person_crop_circle,
                  size: 37,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Container(
            color: Colors.white,
            child: myAction(),
          ),
        ),
      ),
      body: SafeArea(
        child: dashboard(),
      ),
    );
  }

  Widget dashboard() {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(''), // Anda mungkin perlu menambahkan parameter status jika diperlukan
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> data = snapshot.data!;

          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String? field = data[index]['field'];
                  String? ketJasa = data[index]['ket_jasa'];
                  String? nama = data[index]['nama'];
                  double? subtotal = data[index]['subtotal'];
                  String? tglMasuk = data[index]['tgl_masuk'];
                  String? namaBarang = data[index]['nama_barang'];
                  int? jumlahBarang = data[index]['jumlah_barang'];
                  String? tanggal = data[index]['tanggal'];
                  double? totalHarga = data[index]['total_harga'];

                  if (field == 'subtotal') {
                    return Card(
                      child: ListTile(
                        title: Text('Keterangan Jasa: ${ketJasa ?? "N/A"}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama: ${nama ?? "N/A"}'),
                            Text('Subtotal: ${formatCurrency(subtotal ?? 0)}'),
                            Text('Tanggal Masuk: ${tglMasuk ?? "N/A"}'),
                          ],
                        ),
                      ),
                    );
                  } else if (field == 'total_harga') {
                    return Card(
                      child: ListTile(
                        title: Text('Nama Barang: ${namaBarang ?? "N/A"}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah Barang: ${jumlahBarang ?? 0}'),
                            Text('Tanggal: ${tanggal ?? "N/A"}'),
                            Text('Total Harga: ${formatCurrency(totalHarga ?? 0)}'),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget myAction() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          myInfo(),
          const SizedBox(height: 15),
          Divider(
            color: primaryColor,
            thickness: 1,
            height: 10,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => TambahKeuangan()),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add, color: Colors.white,),
                    Text('Tambah', style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Filter',
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => Filter()),
                icon: ImageIcon(
                  const AssetImage('assets/icons/filter.png'),
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pemasukan',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            Text(
              'Pengeluaran',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    const AssetImage('assets/icons/wallet_fill.png'),
                    color: primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text('Rp. X.XXX.XXX,-',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    const AssetImage('assets/icons/wallet_fill.png'),
                    color: primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text('Rp. X.XXX.XXX,-',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}