import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/navigation.dart';
import 'package:tash_clean/tashclean-ta/screen/profile.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Pesanan extends StatefulWidget {
  String? email;
  String? password;
  String? status;
  Pesanan({super.key, this.email, this.password, required this.status});

  @override
  State<Pesanan> createState() => _PesananState(status: status);
}

class _PesananState extends State<Pesanan> {
  String? status;
  _PesananState({this.status});

  Future<List<dynamic>> fetchData(String? status) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.20/api/tashclean/readdata.php?status=$status'),
    );
    print('Fetching data for status: $status');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> updateProses(String documentId) async {
    const apiUrl = 'http://192.168.1.20/api/tashclean/readdataproses.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'_id': documentId}),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == 'Update successful') {
          print('Update successful');
          return 'success';
        } else {
          print('Update failed: ${responseData['message']}');
          return 'failure';
        }
      } else {
        print('Update failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'failure';
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during pemasukan fetch: $e');
      return 'error';
    }
  }

  Future<String> updateSiapAmbil(String documentId) async {
    const apiUrl = 'http://192.168.1.20/api/tashclean/updateambil.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'_id': documentId}),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == 'Update successful') {
          print('Update successful');
          return 'success';
        } else {
          print('Update failed: ${responseData['message']}');
          return 'failure';
        }
      } else {
        print('Update failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'failure';
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during pemasukan fetch: $e');
      return 'error';
    }
  }

  Future<String> updateSelesai(String documentId) async {
    const apiUrl = 'http://192.168.1.20/api/tashclean/updateselesai.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'_id': documentId}),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == 'Update successful') {
          print('Update successful');
          return 'success';
        } else {
          print('Update failed: ${responseData['message']}');
          return 'failure';
        }
      } else {
        print('Update failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'failure';
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during pemasukan fetch: $e');
      return 'error';
    }
  }

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
        resizeToAvoidBottomInset: false,
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
                        builder: (context) => MyProfile(email: widget.email, password: widget.password)
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 37,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(230),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    children: [
                      searchBar(),
                      const SizedBox(height: 10),
                      myStatus()
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
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
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(child: dashboard()),
      ),
    );
  }

  Widget searchBar() {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: primaryColor, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Pesanan',
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
    );
  }

  Widget dashboard() {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<dynamic>>(
        future: fetchData(status),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('Data length: ${snapshot.data?.length}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan indikator loading jika data masih dimuat
            return Center(child: CircularProgressIndicator(color: primaryColor));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (snapshot.data?[index]['keterangan'] == status) {
                    return snapshot.data!.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Icon(CupertinoIcons.person_crop_circle,
                              color: primaryColor,
                              size: 45,
                            ),
                          ),
                          title: Text(snapshot.data?[index]['nama'],
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Masuk : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data?[index]['tgl_masuk']))}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Selesai : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data?[index]['tgl_keluar']))}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("${snapshot.data?[index]['berat']} kg",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12
                                  ),
                                ),
                                Text('${NumberFormat.currency(locale: 'id_ID',symbol: 'Rp. ', decimalDigits: 0)
                                    .format(snapshot.data?[index]['subtotal'] ?? 0)},-',
                                  style: TextStyle(
                                      color: successColor,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  String dialogText;

                                  if (status == 'antrian') {
                                    dialogText = 'Pindahkan ke Proses?';
                                  } else if (status == 'proses') {
                                    dialogText = 'Pindahkan ke Siap Ambil?';
                                  } else if (status == 'siap_ambil') {
                                    dialogText = 'Pindahkan ke Selesai?';
                                  } else {
                                    dialogText = 'Pesanan Selesai';
                                  }

                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    content: Text(dialogText),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Batal')
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            final id = snapshot.data?[index]['_id']['\$oid'];
                                            final currentStatus = snapshot.data?[index]['keterangan'];
                                            if (currentStatus == 'antrian') {
                                              await updateProses(id.toString());
                                            } else if (currentStatus == 'proses') {
                                              await updateSiapAmbil(id.toString());
                                            } else if (currentStatus == 'siap_ambil') {
                                              await updateSelesai(id.toString());
                                            }
                                            await fetchData(status);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => Navigation(selectedPageIndex: 1, status: status, email: widget.email,)
                                              ),
                                            );
                                          },
                                          child: const Text(
                                              'Konfirmasi'
                                          )
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: primaryColor,
                              thickness: 1,
                            )
                        )
                      ],
                    );
                  }
                  return null;
                }
            );
          }
        },
      ),
    );
  }

  Widget myStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Status',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 16
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildStatus('Antrian', 'antrian'),
                buildStatus('Proses', 'proses'),
                buildStatus('Siap Ambil', 'siap_ambil'),
                buildStatus('Selesai', 'selesai'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildStatus(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          color: (status == value) ?
          secondaryColor : Colors.white,
          surfaceTintColor: (status == value) ?
          secondaryColor : Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.transparent,
            onTap: () async {
              setState(() {
                status = value;
              });
              fetchData(status);
            },
            child: Container(
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(label,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}