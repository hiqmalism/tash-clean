import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tash_clean/tashclean-ta/sheet/filter_keuangan.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:tash_clean/tashclean-ta/screen/profile.dart';
import 'package:tash_clean/tashclean-ta/sheet/tambah_keuangan.dart';

class Keuangan extends StatefulWidget {
  String? email;
  String? password;
  double? subtotal;
  double? pengeluaran;
  Keuangan({super.key, this.email, this.password, this.subtotal, this.pengeluaran});

  @override
  State<Keuangan> createState() => _KeuanganState();
}

class PemasukanWidget extends StatelessWidget {
  final Pemasukan pemasukan;

  PemasukanWidget(this.pemasukan);

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: ListTile(
        title: Text(
          'Pemasukan',
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Jasa : ${pemasukan.ketJasa}',
              style: TextStyle(
                color: primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              ' Pelanggan : ${pemasukan.nama}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(pemasukan.tglMasuk))}',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              width: 85,
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: pemasukan.status == 'lunas' ? successColor : tertiaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5))
              ),
              child: Center(
                child: Text(
                  pemasukan.status == 'lunas'
                      ? 'Rp. ${formatCurrency(pemasukan.subtotal)},-'
                      : 'Pending',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class PengeluaranWidget extends StatelessWidget {
  final Pengeluaran pengeluaran;

  PengeluaranWidget(this.pengeluaran);

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: ListTile(
        title: Text(
          'Pengeluaran',
          style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Jenis : ${pengeluaran.namaBarang}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
            Text(
              ' Jumlah : ${pengeluaran.jumlahBarang}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(pengeluaran.tanggal))}',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              width: 85,
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                ),
              child: Center(
                  child: Text(
                    'Rp. ${formatCurrency(pengeluaran.totalHarga)},-',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Pengeluaran2Widget extends StatelessWidget {
  final Pengeluaran2 pengeluaran2;

  Pengeluaran2Widget(this.pengeluaran2);

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: ListTile(
        title: Text(
          'Pengeluaran',
          style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Jenis : ${pengeluaran2.namaPengeluaran}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
            Text(
              ' Jumlah : ${pengeluaran2.jumlahPengeluaran}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(pengeluaran2.tanggalPengeluaran))}',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
                width: 85,
                margin: EdgeInsets.only(bottom: 7),
                padding: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                ),
                child: Center(
                  child: Text(
                    'Rp. ${formatCurrency(pengeluaran2.totalharga)},-',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class _KeuanganState extends State<Keuangan> {
  int subtotal = 0;
  int pengeluaran = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    fecthPemasukan();
    fecthPengeluaran();
  }

  Future<List<Transaksi>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.20/api/tashclean/readtransaksi.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = json.decode(response.body);
        final List<Transaksi> transaksiList = [];

        for (dynamic item in rawData) {
          if (item is Map<String, dynamic>) {
            if (item.containsKey('subtotal')) {
              transaksiList.add(Transaksi('pemasukan', item));
            } else if (item.containsKey('nama_pengeluaran')) {
              transaksiList.add(Transaksi('pengeluaran2', item));
            } else if (item.containsKey('total_harga')) {
              transaksiList.add(Transaksi('pengeluaran', item));
            }
          }
        }

        return transaksiList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<void> fecthPemasukan() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readpemasukan.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        widget.subtotal = double.tryParse(data['subtotal'].toString()) ?? 0.0;
      });
    } else {
      // Handle error
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fecthPengeluaran() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readpengeluaran.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        widget.pengeluaran = double.tryParse(data['total_pengeluaran'].toString()) ?? 0.0;
      });
    } else {
      // Handle error
      print('Failed to load total_pengeluaran: ${response.statusCode}');
    }
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
                      builder: (context) => MyProfile(email: widget.email, password: widget.password)
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  CupertinoIcons.person_crop_circle,
                  size: 35,
                  color: primaryColor,
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
    return FutureBuilder<List<Transaksi>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          // Handle case where data is null or empty
          return Center(child: Text('No data available.'));
        } else {
          List<Transaksi> data = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
            Transaksi transaksi = data[index];

            if (transaksi.type == 'pemasukan') {
              Pemasukan pemasukan = Pemasukan(
                transaksi.data['ket_jasa'] ?? '',
                transaksi.data['nama'] ?? '',
                transaksi.data['status'] ?? '',
                transaksi.data['subtotal'] ?? 0.0,
                transaksi.data['tgl_masuk'] ?? '',
              );
              return PemasukanWidget(pemasukan);
            } else if (transaksi.type == 'pengeluaran') {
              Pengeluaran pengeluaran = Pengeluaran(
                transaksi.data['nama_barang'] ?? '',
                transaksi.data['jumlah_barang'] ?? 0,
                transaksi.data['total_harga'] ?? 0.0,
                transaksi.data['tanggal'] ?? '',
              );
              return PengeluaranWidget(pengeluaran);
              } else if (transaksi.type == 'pengeluaran2') {
              Pengeluaran2 pengeluaran2 = Pengeluaran2(
                transaksi.data['nama_pengeluaran'],
                transaksi.data['jumlah_pengeluaran'],
                transaksi.data['total_harga'] ?? 0.0,
                transaksi.data['tanggal_pengeluaran'] ?? '',
              );
              return Pengeluaran2Widget(pengeluaran2); // Corrected this line
            } else {
              // Handle unknown type or skip this item
              return Container();
            }
          },
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
              Container(
                width: 120,
                height: 24,
                child: ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (BuildContext context) => TambahKeuangan(email: widget.email)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 14,),
                      Text('Tambah', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Filter',
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                  context: context,
                  builder: (BuildContext context) => Filter()),
                icon: ImageIcon(
                  const AssetImage('assets/icons/filter.png'),
                  color: primaryColor,
                  size: 17,
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
                  Text('${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                      .format(widget.subtotal ?? 0)},-',
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
                    Text('${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                        .format(widget.pengeluaran ?? 0)},-',
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

class Transaksi {
  final String type;
  final dynamic data;

  Transaksi(this.type, this.data);
}

class Pemasukan {
  final String ketJasa;
  final String nama;
  final String status;
  final double subtotal;
  final String tglMasuk;

  Pemasukan(this.ketJasa, this.nama, this.status, this.subtotal, this.tglMasuk);
}

class Pengeluaran {
  final String namaBarang;
  final int jumlahBarang;
  final double totalHarga;
  final String tanggal;

  Pengeluaran(this.namaBarang, this.jumlahBarang, this.totalHarga, this.tanggal);
}

class Pengeluaran2 {
  final String namaPengeluaran;
  final int jumlahPengeluaran;
  final double totalharga;
  final String tanggalPengeluaran;

  Pengeluaran2(this.namaPengeluaran, this.jumlahPengeluaran, this.totalharga, this.tanggalPengeluaran);
}
