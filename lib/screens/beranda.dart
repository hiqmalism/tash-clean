import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/form/form_pesanan.dart';
import 'package:tash_clean/form/profil.dart';
import 'package:tash_clean/style.dart';


class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/Tash_2.png',
            ),
          ),
          leadingWidth: 120,
          actions: [
            Container(
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
            preferredSize: Size.fromHeight(45),
            child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hi, Pelanggan',
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
                    child: dashboard()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                Text(
                  'Rp. X.XXX.XXX,-',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                )
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
                          Text('0',
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
                        Text('0',
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
                        Text('0',
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
                        Text('0',
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
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrderForm()
                     ),
                    );
                  },
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/cuci.png',
                  'Cuci',
                  () {
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => OrderForm()
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/setrika.png',
                  'Setrika',
                      () {},
                ),
                const SizedBox(width: 20,),
                buildMenu(
                  'assets/images/cuci_setrika.png',
                  'Cuci + Setrika',
                      () {},
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