import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tash_clean/tashclean-ta/form/form-pesanan.dart';
import 'package:tash_clean/tashclean-ta/form/form-persediaan.dart';
import 'package:tash_clean/tashclean-ta/screen/beranda.dart';
import 'package:tash_clean/tashclean-ta/screen/pesanan.dart';
import 'package:tash_clean/tashclean-ta/screen/keuangan.dart';
import 'package:tash_clean/tashclean-ta/screen/persediaan.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class Navigation extends StatefulWidget {
  int selectedPageIndex;
  String? email;
  String? status;
  String? nama;
  String? password;
  Navigation({super.key, this.email, this.status, this.nama, this.password, required this.selectedPageIndex});

  @override
  _NavigationState createState() => _NavigationState(selectedPageIndex);
}

class _NavigationState extends State<Navigation> {
  int selectedPageIndex;
  _NavigationState(this.selectedPageIndex);

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      Beranda(email: widget.email, nama: widget.nama, password: widget.password),
      Pesanan(email: widget.email, password: widget.password, status: widget.status),
      Keuangan(email: widget.email, password: widget.password),
      Persediaan(email: widget.email, password: widget.password, jumlahBarang: 0, jumlahKeluar: 0),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: selectedPageIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: bottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(CupertinoIcons.add, color: Colors.white),
          onPressed: () => showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Card(
                        color: Colors.white,
                        child: ListTile(
                          splashColor: secondaryColor,
                          leading: ImageIcon(
                            const AssetImage('assets/icons/wash_machine.png'),
                            color: primaryColor,
                          ),
                          title: Text(
                            'Tambah Pesanan',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderForm(email: widget.email),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Card(
                        color: Colors.white,
                        child: ListTile(
                          splashColor: secondaryColor,
                          leading: ImageIcon(
                            const AssetImage('assets/icons/laundry-detergent.png'),
                            color: primaryColor,
                          ),
                          title: Text(
                            'Tambah Stok',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersediaanForm(email: widget.email),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget bottomNav() {
    return BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      notchMargin: 0.01,
      clipBehavior: Clip.antiAlias,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            unselectedItemColor: primaryColor,
            selectedItemColor: primaryColor,
            currentIndex: selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: selectedPageIndex == 0
                    ? const ImageIcon(AssetImage('assets/icons/home_fill.png'))
                    : const ImageIcon(AssetImage('assets/icons/home.png')),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: selectedPageIndex == 1
                    ? const ImageIcon(AssetImage('assets/icons/clipboard_fill.png'))
                    : const ImageIcon(AssetImage('assets/icons/clipboard.png')),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: selectedPageIndex == 2
                    ? const ImageIcon(AssetImage('assets/icons/graph_fill.png'))
                    : const ImageIcon(AssetImage('assets/icons/graph.png')),
                label: 'Keuangan',
              ),
              BottomNavigationBarItem(
                icon: selectedPageIndex == 3
                    ? const ImageIcon(AssetImage('assets/icons/readystock_fill.png'))
                    : const ImageIcon(AssetImage('assets/icons/readystock.png')),
                label: 'Persediaan',
              ),
            ],
          ),
        ],
      ),
    );
  }
}