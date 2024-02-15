import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:tash_clean/tashclean-ta/form/pembayaran.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class OrderForm extends StatefulWidget {
  String? email;
  String? selectedJasa;
  String? selectedPengiriman;
  OrderForm({super.key, this.email, this.selectedJasa, this.selectedPengiriman});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {

  String? _nama;
  String? _no_hp;
  String? _berat;
  String? _alamat;
  String? _selectedKategori;
  double? _subtotal;
  double? totalJasa;
  double? biayaPengiriman;
  double? hargaJasa;
  String? randomId;
  DateTime tglMasuk = DateTime.now();
  DateTime? tglKeluar;

  final _alamatController = TextEditingController();

  Future<void> sendPostRequest(BuildContext context) async {


    if (_selectedKategori == 'reguler') {
      tglKeluar = tglMasuk.add(Duration(days: 3));
    } else if (_selectedKategori == 'express') {
      tglKeluar = tglMasuk.add(Duration(days: 1));
    } else {
      // Handle kondisi lain jika diperlukan
      tglKeluar = DateTime.now(); // Default
    }

    var uuid = Uuid();
    randomId = uuid.v4();
    _alamat = _alamatController.text;

    print(widget.selectedPengiriman);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Checkout(
        email: widget.email,
        randomId: randomId,
        nama: _nama,
        no_hp: _no_hp,
        berat: _berat,
        alamat: _alamat,
        selectedJasa: widget.selectedJasa,
        selectedKategori: _selectedKategori,
        selectedPengiriman: widget.selectedPengiriman,
        tglMasuk: tglMasuk,
        tglKeluar: tglKeluar,
        biayaPengiriman: biayaPengiriman ?? 0.0,
        totalJasa: totalJasa ?? 0.0,
        subtotal: _subtotal ?? 0.0,
      )),
    );

    setState(() {
      _subtotal = calculateSubtotal();
    });
  }

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat("#,###", "id_ID");
    return currencyFormat.format(amount);
  }

  double calculateSubtotal() {
    // double hargaPerKg;

    // Tentukan harga jasa berdasarkan _selectedKategori dan ket_jasa
    if (_selectedKategori == 'reguler') {
      if (widget.selectedJasa == 'cuci') {
        hargaJasa = 4000;
      } else if (widget.selectedJasa == 'setrika') {
        hargaJasa = 3000;
      } else if (widget.selectedJasa == 'cuci setrika') {
        hargaJasa = 5000;
      } else {
        // Handle kondisi lain jika diperlukan
        hargaJasa = 0; // Default
      }
    } else if (_selectedKategori == 'express') {
      if (widget.selectedJasa == 'cuci') {
        hargaJasa = 5000;
      } else if (widget.selectedJasa == 'setrika') {
        hargaJasa = 4000;
      } else if (widget.selectedJasa == 'cuci setrika') {
        hargaJasa = 6000;
      } else {
        // Handle kondisi lain jika diperlukan
        hargaJasa = 0; // Default
      }
    } else {
      // Handle kondisi lain jika diperlukan
      hargaJasa = 0; // Default
    }

    // Tentukan biaya pengiriman berdasarkan pengiriman
    if (widget.selectedPengiriman == 'penjemputan') {
      biayaPengiriman = 3000;
    } else if (widget.selectedPengiriman == 'ambil') {
      biayaPengiriman = 0;
    } else {
      // Handle kondisi lain jika diperlukan
      biayaPengiriman = 0; // Default
    }

    // Hitung subtotal
    double berat = double.tryParse(_berat ?? '0') ?? 0;
    totalJasa = berat * (hargaJasa ?? 0);
    double _subtotal = totalJasa! + (biayaPengiriman ?? 0);
    return _subtotal;
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
            'Tambah Pesanan',
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
        body: myForm(),
        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal\nRp. ${formatCurrency(calculateSubtotal())},-', // Format harga
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
                    sendPostRequest(context);
                  },
                  style:
                  ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))
                  ),
                  child: Text('Lanjutkan\nPembayaran',
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

  Widget myForm() {
    return ListView(
      children: [
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
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama',
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
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama customer',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: tertiaryColor,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  onChanged: (String val) {
                    setState(() {
                      _nama = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Text('No WhatsApp',
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
                  decoration: InputDecoration(
                    hintText: 'Masukkan no whatsapp',
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
                  keyboardType: TextInputType.phone,
                  onChanged: (String val) {
                    setState(() {
                      _no_hp = val;
                    });
                  },

                ),
              ),
              const SizedBox(height: 10,),
              Text('Berat',
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
                  decoration: InputDecoration(
                    hintText: 'Masukkan berat/kg',
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
                  onChanged: (String val) {
                    setState(() {
                      _berat = val;
                    });
                  },

                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 23),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 15),
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
              Text('Pilihan Jasa',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 5),
              Row(
                children: [
                  jasaRadio('Cuci', 'cuci', 'assets/icons/washing-machine.png'),
                  jasaRadio('Setrika', 'setrika', 'assets/icons/iron.png'),
                  jasaRadio('Cuci + Setrika', 'cuci setrika', 'assets/icons/laundry.png'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 23),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 15),
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
              Text('Pengiriman',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 5),
              Row(
                children: [
                  pengirimanRadio('Penjemputan', 'penjemputan', 'assets/icons/delivery.png'),
                  pengirimanRadio('Ambil Sendiri', 'ambil', 'assets/icons/ambil.png'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 23),

        if (widget.selectedPengiriman == 'penjemputan')
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
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
                    Text('Alamat',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: offColor,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan alamat penjemputan',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: tertiaryColor,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: errorColor)
                          ),
                          errorStyle: TextStyle(
                              color: errorColor
                          ),
                        ),
                        enabled: widget.selectedPengiriman == 'penjemputan',
                        controller: _alamatController,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: tertiaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
            ],
          ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
              Text('Pilih Kategori',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  kategoriRadio('Reguler', 'reguler'),
                  kategoriRadio('Express', 'express'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget jasaRadio(String text, String value, String img) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: offColor,
        surfaceTintColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (widget.selectedJasa == value) ?
            BorderRadius.circular(10)
                : null,
            border: (widget.selectedJasa == value) ?
            Border.all(
                style: BorderStyle.solid,
                width: 2,
                color: primaryColor
            ) : null,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(7),
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                widget.selectedJasa = (widget.selectedJasa == value) ? null: value;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: secondaryColor,
                  child: ImageIcon(AssetImage(img),
                    color: primaryColor,
                    size: 35,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pengirimanRadio(String text, String value, String img) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: offColor,
        surfaceTintColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (widget.selectedPengiriman == value) ?
            BorderRadius.circular(10)
                : null,
            border: (widget.selectedPengiriman == value) ?
            Border.all(
                style: BorderStyle.solid,
                width: 2,
                color: primaryColor
            ) : null,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(7),
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                widget.selectedPengiriman = (widget.selectedPengiriman == value) ? null: value;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: secondaryColor,
                  child: ImageIcon(AssetImage(img),
                    color: primaryColor,
                    size: 35,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kategoriRadio(String text, String value) {
    return Card(
      color: offColor,
      surfaceTintColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: (_selectedKategori == value) ?
          BorderRadius.circular(10)
              : null,
          border: (_selectedKategori == value) ?
          Border.all(
              style: BorderStyle.solid,
              width: 2,
              color: primaryColor
          ) : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              _selectedKategori = (_selectedKategori == value) ? null: value;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}