import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tash_clean/style.dart';
import 'mobile.dart' if(dart.library.html) 'web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: NotePage()
    );
  }
}

class NotePage extends StatefulWidget {
  NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Image.asset('assets/images/Tash_Laundry.png',),
                        title: Text(
                          'Tash Clean',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primaryColor
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jl. XXXX No. xx',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Image.asset('assets/icons/qr_code.png', width: 100)
                  ],
                ),
                SizedBox(height: 10),
                Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tanggal Pesanan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor
                                  ),
                                ),
                              ],
                            )
                        ),
                        TableCell(
                          child: Text(
                            ' ID-012345',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor
                            ),
                          )
                        ),
                        TableCell(child: Container()),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Customer',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                        ),
                        TableCell(
                            child: Text(
                              ' John Doe',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        TableCell(child: Container()),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tanggal Pesanan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                        ),
                        TableCell(
                            child: Text(
                              ' 01-01-2021',
                              style: TextStyle(
                                  fontSize: 12,
                              ),
                            )
                        ),
                        TableCell(child: Container()),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tanggal Selesai',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                        ),
                        TableCell(
                            child: Text(
                              ' 04-01-2021',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                        ),
                        TableCell(child: Container()),
                      ],
                    ),
                  ],
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(bottom: 5),
                //         child: Text(
                //           'ID Pesanan\t : ID-012345',
                //           style: TextStyle(
                //             fontSize: 12,
                //             fontWeight: FontWeight.bold,
                //             color: primaryColor
                //           ),
                //         ),
                //       ),
                //       Text(
                //         'Nama Customer\t\t\t\t : John Doe',
                //         style: TextStyle(
                //             fontSize: 12,
                //             fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Text(
                //         'Tanggal Pesanan\t\t : 01-01-2021',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Text(
                //         'Tanggal Selesai\t\t\t\t\t  : 02-02-2002',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: primaryColor,
                                child: Text(
                                  'Layanan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                            )
                        ),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: primaryColor,
                                child: Text(
                                  'Berat',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                            )
                        ),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: primaryColor,
                                child: Text(
                                  'Subtotal',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                            )
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: secondaryColor,
                                child: Text(
                                  'Cuci + Setrika',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                            )
                        ),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: secondaryColor,
                                child: Text(
                                  '5 kg',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                            )
                        ),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                color: secondaryColor,
                                child: Text(
                                  'Rp. 20.000,-',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                            )
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Biaya Jasa :',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Rp. 16.000,-',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.symmetric(horizontal: BorderSide.none, vertical: BorderSide(color: primaryColor))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Biaya Pengiriman :',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Rp. 4.000,-',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(child: Container(padding: EdgeInsets.all(5))),
                        TableCell(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: errorColor
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tagihan Pembayaran :',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    Text(
                                      'Rp. 2.000,-',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(10),
                  color: successColor,
                  alignment: Alignment.center,
                  child: Text(
                    'LUNAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Divider(),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Terima kasih telah menggunakan aplikasi ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: primaryColor
                        ),
                      ),
                      Image.asset('assets/icons/tash_landscape.png', width: 70,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

