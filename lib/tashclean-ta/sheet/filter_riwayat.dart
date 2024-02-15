import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class FilterRiwayat extends StatefulWidget {
  final void Function(String?, String?) onFilterApplied;

  // Constructor
  FilterRiwayat({required this.onFilterApplied});


  @override
  _FilterRiwayatState createState() => _FilterRiwayatState();
}

class _FilterRiwayatState extends State<FilterRiwayat> {
  String? _filterKategori;
  String? _filterWaktu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Pilih Filter',
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Berdasarkan Kategori',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      filterKategori('Masuk', 'masuk'),
                      filterKategori('Keluar', 'keluar'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Berdasarkan Waktu',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      filterWaktu('Hari ini', 'hari'),
                      filterWaktu('Minggu ini', 'minggu'),
                      filterWaktu('Bulan ini', 'bulan'),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: 150,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        onPressed: () {
                          // Access the callback function from the parent widget
                          widget.onFilterApplied?.call(_filterKategori, _filterWaktu);
                          // Close the bottom sheet after applying the filter
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Terapkan',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget filterKategori(String text, String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          _filterKategori = (_filterKategori == value) ? null: value;
        });
      },
      child: Card(
        color: (_filterKategori == value) ?
        secondaryColor : Colors.white,
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
    );
  }

  Widget filterWaktu(String text, String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          _filterWaktu = (_filterWaktu == value) ? null: value;
        });
      },
      child: Card(
        color: (_filterWaktu == value) ? secondaryColor : Colors.white,
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
    );
  }
}
