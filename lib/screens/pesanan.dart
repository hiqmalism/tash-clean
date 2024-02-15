import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tash_clean/form/profil.dart';
import 'package:tash_clean/style.dart';


class Pesanan extends StatefulWidget {
  const Pesanan({super.key});

  @override
  State<Pesanan> createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  String? _status = 'antrian';

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
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: dashboard()
        ),
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
            Icon(FontAwesomeIcons.magnifyingGlass, color: primaryColor),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        children: [],
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
        // TabBar(
        //   isScrollable: true,
        //   tabAlignment: TabAlignment.center,
        //   dividerColor: Colors.transparent,
        //   labelColor: primaryColor,
        //   unselectedLabelColor: primaryColor,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   indicator: BoxDecoration(
        //     color: secondaryColor,
        //     borderRadius: BorderRadius.circular(10),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.2),
        //         spreadRadius: 0, blurRadius: 5,
        //         // offset: Offset(0, 3)
        //       )
        //     ]
        //   ),
        //   tabs: [
        //     buildStatus('Antrian', 'antrian'),
        //     buildStatus('Proses', 'proses'),
        //     buildStatus('Siap Ambil', 'siap_ambil'),
        //     buildStatus('Selesai', 'selesai'),
        //   ]
        // ),
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

  Widget daftarPesanan() {
    return Container(
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
      child: Column(
        children: [
            Container(height: 392),
        ],
      ),
    );
  }

  Widget buildStatus(String label, String value) {
    return Card(
      color: (_status == value) ?
      secondaryColor : Colors.white,
      surfaceTintColor: (_status == value) ?
      secondaryColor : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            _status = value;
          });
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
    );
  }
}
