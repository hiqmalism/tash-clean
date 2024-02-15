import 'package:flutter/material.dart';
import 'package:tash_clean/form/checkout/checkout.dart';
import 'package:tash_clean/style.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

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
        body: const MyForm(),
        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal\nRp. XX.XXX.XXX,-',
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
                      MaterialPageRoute(builder: (context) => const Checkout()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
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
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String? _selectedJasa;
  String? _selectedPengiriman;
  String? _selectedKategori;
  final _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

        if (_selectedPengiriman == 'penjemputan')
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
                        enabled: _selectedPengiriman == 'penjemputan',
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
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: (_selectedJasa == value) ?
            BorderRadius.circular(10)
            : null,
            border: (_selectedJasa == value) ?
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
                _selectedJasa = (_selectedJasa == value) ? null: value;
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
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: (_selectedPengiriman == value) ?
            BorderRadius.circular(10)
                : null,
            border: (_selectedPengiriman == value) ?
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
                _selectedPengiriman = (_selectedPengiriman == value) ? null: value;
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
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
