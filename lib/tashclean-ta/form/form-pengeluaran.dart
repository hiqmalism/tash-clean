import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tash_clean/tashclean-ta/screen/navigation.dart';

class Pengeluaran extends StatefulWidget {
  String? email;

  Pengeluaran({super.key, this.email});

  @override
  State<Pengeluaran> createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {
  TextEditingController _datetime = TextEditingController();
  DateTime selectedDate = DateTime.now();

  TextEditingController _datetimeController = TextEditingController();
  TextEditingController _namaPengeluaranController = TextEditingController();
  TextEditingController _jmlhPengeluaranController = TextEditingController();
  TextEditingController _totalHargaController = TextEditingController();

  Future<void> _tambahPersediaan() async {
    final String apiUrl = "http://192.168.1.20/api/tashclean/tambahpengeluaran.php";
    var response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email" : widget.email,
          "nama_pengeluaran" : _namaPengeluaranController.text,
          "jumlah_pengeluaran" : _jmlhPengeluaranController.text,
          "total_harga" : _totalHargaController.text,
          "tanggal_pengeluaran": _datetimeController.text,
        }
        )
    );
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Navigation(selectedPageIndex: 2, email: widget.email)),
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
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Tambah Pengeluaran',
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

        body: ListView(
          children: [
            Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Jenis Pengeluaran',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: offColor,
                    ),
                    child: TextFormField(
                      controller: _namaPengeluaranController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan jenis pengeluaran',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: tertiaryColor,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: errorColor)
                        ),
                        errorStyle: TextStyle(
                            color: errorColor
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tertiaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text('Jumlah Pengeluaran',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF3F2F2),
                    ),
                    child: TextFormField(
                      controller: _jmlhPengeluaranController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan jumlah pengeluaran',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: tertiaryColor,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tertiaryColor,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text('Total',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: offColor,
                    ),
                    child: TextFormField(
                      controller: _totalHargaController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan total pengeluaran',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: tertiaryColor,
                        ),
                        filled: true,
                        fillColor: Colors.transparent, // Set this to transparent
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tertiaryColor,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text('Tanggal',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: offColor,
                    ),
                    child: TextFormField(
                      controller: _datetime,
                      decoration: InputDecoration(
                          hintText: '${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: tertiaryColor,
                          ),
                          filled: true,
                          fillColor: Colors.transparent, // Set this to transparent
                          border: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(

                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100)
                              );

                              if(pickedDate != null) {
                                setState(() {
                                  _datetime.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                                });
                              }
                            },
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: tertiaryColor,
                            ),
                          )
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tertiaryColor,
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _tambahPersediaan,
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Text('Simpan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
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
