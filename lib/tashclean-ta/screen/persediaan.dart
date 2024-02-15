import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/form/form-persediaan.dart';
import 'package:tash_clean/tashclean-ta/screen/navigation.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tash_clean/tashclean-ta/screen/profile.dart';
import 'package:intl/intl.dart';

class Persediaan extends StatefulWidget {
  final String? email;
  String? password;
  double? jumlahBarang;
  double? jumlahKeluar;

  Persediaan({super.key, this.email, this.password, this.jumlahBarang, this.jumlahKeluar});

  @override
  State<Persediaan> createState() => _PersediaanState();
}

class _PersediaanState extends State<Persediaan> {
  String? _periksa = 'persediaan';

  @override
  void initState() {
    super.initState();
    fetchBarangMasuk();
    fetchBarangKeluar();
  }


  Future<void> fetchBarangMasuk() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readpersediaan.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('jumlah_barang')) {
        setState(() {
          widget.jumlahBarang = double.tryParse(data['jumlah_barang'].toString()) ?? 0.0;
        });
      } else {
        print('Unexpected response format: $data');
      }
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> fetchBarangKeluar() async {
    final response = await http.get(Uri.parse("http://192.168.1.20/api/tashclean/readstokkeluar.php"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('jumlah_keluar')) {
        setState(() {
          widget.jumlahKeluar = double.tryParse(data['jumlah_keluar'].toString()) ?? 0.0;
        });
      } else {
        print('Unexpected response format: $data');
      }
    } else {
      print('Failed to load subtotal: ${response.statusCode}');
    }
  }

  Future<void> createBarangKeluar(String barangKeluar, int jumlahKeluar) async {
    final response = await http.post(
      Uri.parse("http://192.168.1.20/api/tashclean/createstokkeluar.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode ({
        'email': widget.email,
        'nama_barang': barangKeluar,
        'jumlah_keluar': jumlahKeluar.toString(),
        'tanggal_keluar': DateTime.now().toString(),
      }),
    );
    print("Response persediaan: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        print('Stock updated and record added successfully');
      } else {
        print('Failed to update stock: ${data['message']}');
      }
    } else {
      print('Failed to update stock: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchStok() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.20/api/tashclean/readbarang.php'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fetchRiwayat() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.20/api/tashclean/readriwayat.php'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
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
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: Container(
            color: primaryColor,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/Tash_2.png',
            ),
          ),
          leadingWidth: 120,
          actions: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.all(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyProfile(email: widget.email,password: widget.password)
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
            preferredSize: Size.fromHeight(
                (_periksa == 'persediaan') ? 265 : 326
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    children: [
                      myInfo(),
                      const SizedBox(height: 10),
                      myPeriksa(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, -5)
                      )
                    ],
                  ),
                  child: myTab()
                ),
              ],
            ),
          ),
        ),
          body: SafeArea(
            child: _periksa == 'persediaan' ? stokBarang() : riwayatStok(),
          ),
      ),
    );
  }

  Widget myInfo() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/stock.png', width: 50),
                        Column(
                          children: [
                            Text(
                              'Stok Barang',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${(widget.jumlahBarang! - (widget.jumlahKeluar ?? 0 ))}',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Stok Keluar',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${widget.jumlahKeluar ?? 0 }',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/stock.png', width: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myPeriksa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Periksa',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildPeriksa('Persediaan', 'persediaan'),
              buildPeriksa('Riwayat', 'riwayat'),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPeriksa(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Card(
            color: (_periksa == value) ?
            secondaryColor : Colors.white,
            surfaceTintColor: (_periksa == value) ?
            secondaryColor : Colors.white,
            child: InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                setState(() {
                  _periksa = (_periksa == value) ? null : value;
                });
              },
              child: Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget stokBarang() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 30),
        child: FutureBuilder<List<dynamic>>(
          future: fetchStok(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text(
                'Data Kosong.',
                style: TextStyle(
                 color: primaryColor,
                 fontWeight: FontWeight.bold
                ))
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return buildPersediaanCard(
                    '${snapshot.data?[index]['nama_barang']}',
                    '${snapshot.data?[index]['total_jumlah']}',
                  );
                },
              );
            }
          },
        )
    );
  }

  Widget buildPersediaanCard(String label, String amount) {
    if (label.isEmpty || amount.isEmpty) {
      return SizedBox.shrink();
    }

    String capitalizeFirstLetter(String text) {
      if (text.isEmpty) {
        return text;
      }
      return text[0].toUpperCase() + text.substring(1);
    }

    label = capitalizeFirstLetter(label);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: InkWell(
          splashColor: secondaryColor,
          onTap: () => _openDialog(label, amount),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.asset('assets/images/stock.png', width: 70),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget riwayatStok() {

    String capitalizeFirstLetter(String text) {
      if (text.isEmpty) {
        return text;
      }
      return text[0].toUpperCase() + text.substring(1);
    }

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 30),
        child: FutureBuilder<List<dynamic>>(
        future: fetchRiwayat(),
        builder: (context, snapshot) {
          print('Data length Riwayat: ${snapshot.data?.length}');
          print('Data Riwayat: ${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: primaryColor));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text(''));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                capitalizeFirstLetter("${snapshot.data?[index]['nama_barang']}");
                return Column(
                  children: [
                    if (snapshot.data?[index]['jumlah_barang'] != null)
                      ListTile(
                        leading: Image.asset('assets/images/stock.png'),
                        title: Text(
                          '${snapshot.data?[index]['nama_barang']}',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal : ${DateFormat('yyyy/MM/dd').format(DateTime.parse(snapshot.data?[index]['tanggal']))}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Jumlah : ${snapshot.data?[index]['jumlah_barang']}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 29),
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Masuk",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.arrow_upward, color: successColor, size: 12)
                              ],
                            ),
                          ),
                        ),
                      )
                    else if (snapshot.data?[index]['jumlah_barang'] == 0)
                      Container()
                    else if (snapshot.data?[index]['tanggal_keluar'] != null)
                      ListTile(
                        leading: Image.asset('assets/images/stock.png'),
                        title: Text(
                          '${snapshot.data?[index]['nama_barang']}',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal : ${DateFormat('yyyy/MM/dd').format(DateTime.parse(snapshot.data?[index]['tanggal_keluar']))}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Jumlah : ${snapshot.data?[index]['jumlah_keluar']}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 29),
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Keluar",
                                  style: TextStyle(
                                    color: errorColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.arrow_downward, color: errorColor, size: 12)
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        )
      );
    }


  Widget myTab() {
    if (_periksa == 'persediaan') {
      return Center(
        child: Text(
          'Daftar Persediaan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 14,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, color: primaryColor, size: 20,),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Stok',
                        hintStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              tooltip: 'Filter',
                onPressed: () {},
              icon: ImageIcon(
                const AssetImage('assets/icons/filter.png'),
                color: primaryColor,
              ),
            ),
          ),
          Divider(color: primaryColor)
        ],
      );
    }
  }

  void _openDialog(String label, String amount) {
    double initialAmount = double.parse(amount);
    double amountKeluar = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/stock.png', width: 90),
                SizedBox(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (initialAmount > 0) {
                                setState(() {
                                  initialAmount -= 1;
                                  amountKeluar += 1;
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: primaryColor,
                                ),
                              ),
                              child: Icon(
                                CupertinoIcons.minus,
                                size: 15,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            initialAmount.toStringAsFixed(0),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => PersediaanForm(email: widget.email,)
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: primaryColor,
                                ),
                              ),
                              child: Icon(
                                CupertinoIcons.add,
                                size: 15,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await createBarangKeluar(label, amountKeluar.toInt());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) =>
                        Navigation(selectedPageIndex: 3, email: widget.email, )
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
