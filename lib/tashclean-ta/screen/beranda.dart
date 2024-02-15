import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/form/form-pesanan.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tash_clean/tashclean-ta/screen/profile.dart';


void main() {
  runApp(Beranda());
}

class Beranda extends StatefulWidget {
  String? email;
  String? nama;
  String? password;
  double? subtotal;
  double? pengeluaran;
  double? pengiriman;
  double? cuci;
  double? setrika;
  double? cucisetrika;
  double? saldo;

  Beranda({
    super.key,
    this.email,
    this.nama,
    this.password,
    this.subtotal,
    this.pengiriman,
    this.cuci,
    this.setrika,
    this.cucisetrika,
    this.pengeluaran,
    this.saldo
  });

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int subtotal = 0;
  int pengiriman = 0;
  int cuci = 0;
  int setrika = 0;
  int cucisetrika = 0;
  int pengeluaran = 0;
  int saldo = 0;

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      fetchUser();
      fetchPemasukan();
      fetchPengeluaran();
      fetchPengiriman();
      fetchCuci();
      fetchSetrika();
      fetchCuciSetrika();
      fetchSaldo();
    } else {
      print('Email tidak tersedia.');
    }
  }

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  Future<void> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.20/api/tashclean/readuser.php?email=${Uri.encodeComponent(widget.email ?? '')}"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
          // Assuming you want to process the first user in the list
          final Map<String, dynamic> data = dataList[0];

          if (data.containsKey('error')) {
            print('Error from server: ${data['error']}');
          } else if (data.containsKey('nama_lengkap')) {
            setState(() {
              widget.nama = data['nama_lengkap'];
            });
            print('DATA USER: ${response.body}');
          } else {
            print('User data does not contain the expected field: ${response.body}');
          }
        } else {
          print('User data list is empty.');
        }
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchPemasukan() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readpemasukan.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        subtotal = data['subtotal'] ?? 0;
        widget.subtotal = double.tryParse(data['subtotal'].toString()) ?? 0.0;
        fetchSaldo();
      });
    } else {
      // Handle error
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchPengeluaran() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readpengeluaran.php"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        pengeluaran = data['total_pengeluaran'] ?? 0;
        widget.pengeluaran = double.tryParse(data['total_pengeluaran'].toString()) ?? 0.0;
        fetchSaldo();
      });
    } else {
      // Handle error
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchPengiriman() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readinfo.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        pengiriman = data['jumlah_pengiriman'] ?? 0;
        widget.pengiriman = double.tryParse(data['jumlah_pengiriman'].toString()) ?? 0;
        fetchSaldo();
      });
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchCuci() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readcuci.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        cuci = data['jumlah_cuci'] ?? 0;
        widget.cuci = double.tryParse(data['jumlah_cuci'].toString()) ?? 0;
        // fetchSaldo();
      });
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchSetrika() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readsetrika.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        setrika = data['jumlah_setrika'] ?? 0;
        widget.setrika = double.tryParse(data['jumlah_setrika'].toString()) ?? 0;
        // fetchSaldo();
      });
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchCuciSetrika() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readcucisetrika.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        cucisetrika = data['jumlah_cucisetrika'] ?? 0;
        widget.cucisetrika = double.tryParse(data['jumlah_cucisetrika'].toString()) ?? 0;
      });
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchSaldo() async {
    try {
      double? pemasukan = widget.subtotal;
      double? pengeluaran = widget.pengeluaran;

      pemasukan ??= 0.0;
      pengeluaran ??= 0.0;

      double saldo = pemasukan - pengeluaran;

      setState(() {
        print("Pemasukan : ${pemasukan}");
        widget.saldo = saldo;
      });
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
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
          backgroundColor: Colors.transparent,
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
                        builder: (context) => MyProfile(email: widget.email, password: widget.password,)
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
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, ${widget.nama ?? 'Pengguna'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              Expanded(
                child:
                SingleChildScrollView(
                    child: Dashboard()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Dashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(10),
          child: myInfo(),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('Layanan',
            style: TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: myMenu(),
        ),
      ],
    );
  }

  Widget myInfo() {
    return Container(
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
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Sisa saldo tersedia',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
                Text('${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                    .format(widget.saldo ?? 0)},-', style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
          Divider(color: tertiaryColor),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 17, 15, 17),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Informasi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: secondaryColor,
                            child: ImageIcon(
                              const AssetImage('assets/icons/delivery.png'),
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Penjemputan',
                            style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text('${widget.pengiriman}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondaryColor,
                          child: ImageIcon(const AssetImage('assets/icons/washing-machine.png'),
                            color: primaryColor,
                            size: 25,
                          ),
                        ),
                        Text(
                          'Cuci',
                          style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text('${widget.cuci}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondaryColor,
                          child: ImageIcon(const AssetImage('assets/icons/iron.png'),
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        Text(
                          'Setrika',
                          style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text('${widget.setrika}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondaryColor,
                          child: ImageIcon(const AssetImage('assets/icons/laundry.png'),
                            color: primaryColor,
                            size: 23,
                          ),
                        ),
                        Text(
                          'Cuci + Setrika',
                          style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text('${widget.cucisetrika}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget myMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMenu(
                  'assets/images/penjemputan.png',
                  'Penjemputan',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderForm(selectedPengiriman: 'penjemputan', email: widget.email)
                      )
                    );
                  },
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/cuci.png',
                  'Cuci',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderForm(selectedJasa: 'cuci', email: widget.email)
                        )
                    );
                  },
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/setrika.png',
                  'Setrika',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderForm(selectedJasa: 'setrika', email: widget.email)
                        )
                    );
                  },
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/cuci_setrika.png',
                  'Cuci + Setrika',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderForm(selectedJasa: 'cuci setrika', email: widget.email)
                        )
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(String imagePath, String label, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            splashColor: secondaryColor,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [secondaryColor, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                imagePath, height: 60, width: 60,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 10
          ),
        ),
      ],
    );
  }
}