import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tash_clean/form/form_pesanan.dart';
import 'package:tash_clean/form/persediaan_form.dart';
import 'package:tash_clean/screens/beranda.dart';
import 'package:tash_clean/screens/pesanan.dart';
import 'package:tash_clean/screens/keuangan.dart';
import 'package:tash_clean/screens/persediaan.dart';
import 'package:tash_clean/style.dart';

class Navigation extends StatefulWidget {
  final int selectedPageIndex;
  Navigation({super.key, required this.selectedPageIndex});

  @override
  _NavigationState createState() => _NavigationState(selectedPageIndex);
}

class _NavigationState extends State<Navigation> {
  int selectedPageIndex;
  _NavigationState(this.selectedPageIndex);

  static final List<Widget> _widgetOptions = <Widget>[
    Beranda(),
    Pesanan(),
    Keuangan(),
    Persediaan(),
  ];

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
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 170,
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
                      Card(
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
                                builder: (context) => OrderForm(),
                              ),
                            );
                          },
                        ),
                      ),
                      Card(
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
                                builder: (context) => const PersediaanForm(),
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
