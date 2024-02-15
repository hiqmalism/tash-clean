import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tash_clean/form/persediaan_form.dart';
import 'package:tash_clean/form/profil.dart';
import 'package:tash_clean/persediaan/filter_riwayat.dart';
import 'package:tash_clean/style.dart';


class Persediaan extends StatefulWidget {
  const Persediaan({super.key});

  @override
  State<Persediaan> createState() => _PersediaanState();
}

class _PersediaanState extends State<Persediaan> {
  String? _periksa = 'persediaan';
  int _amount = 0;
  int _initialAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [primaryColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
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
            preferredSize: const Size.fromHeight(260),
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
                    padding: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, -5)
                        )
                      ],
                    ),
                    child: Column(
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
                                Icon(Icons.search_rounded, color: primaryColor),
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
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) => FilterRiwayat()
                            ),
                            icon: ImageIcon(
                              const AssetImage('assets/icons/filter.png'),
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Divider(color: primaryColor)
                      ],
                    ),
                    // Center(
                    //   child: Text(
                    //     'Daftar Persediaan',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: primaryColor,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        body: SafeArea(
          child: stokBarang()
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
                              '0',
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
                              '0',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
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
                  _periksa = value;
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
      child: ListView(
        children: [
          buildPersediaanCard('Detergen Cair', '$_amount'),
          buildPersediaanCard('Pewangi', '$_amount'),
          buildPersediaanCard('Plastik', '$_amount'),
        ],
      ),
    );
  }

  Widget buildPersediaanCard(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: InkWell(
          splashColor: secondaryColor,
          onTap: () => _openDialog(label),
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

  void _openDialog(String label) {
    int currentAmount = _amount;

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
                              // if (_amount > 0) {
                                setState(() {
                                  currentAmount--;
                                });
                              // }
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        style: BorderStyle.solid,
                                        color: primaryColor
                                    )
                                ),
                                child: Icon(CupertinoIcons.minus, size: 15, color: primaryColor,)
                            ),
                          ),
                          Text(
                            currentAmount.toString(),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentAmount++;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: primaryColor
                                  )
                                ),
                              child: Icon(CupertinoIcons.add, size: 15, color: primaryColor,)
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
                  setState(() {
                    currentAmount = _initialAmount;
                  });
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
                onPressed: () {
                  setState(() {
                    _amount = currentAmount;
                    _initialAmount = currentAmount;
                  });
                  Navigator.pop(context);
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

  Widget riwayat() {
    return Container(height: 5000);
  }
}