import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'mobile.dart' if(dart.library.html) 'web.dart';
import 'package:tash_clean/style.dart';
import 'package:dotted_line/dotted_line.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class OrderNote extends StatefulWidget {
  const OrderNote({super.key});

  @override
  State<OrderNote> createState() => _OrderNoteState();
}

class _OrderNoteState extends State<OrderNote> {
  final gap = const SizedBox(height: 5);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Pembayaran',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: primaryColor,
            shadowColor: Colors.transparent,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                strukPembelian(),
                IconButton(
                  onPressed: _createPDF,
                  icon: ImageIcon(
                    const AssetImage('assets/icons/share.png'),
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: primaryColor,
            surfaceTintColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal\nRp. XX.XXX,-',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Kembali',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget strukPembelian() {
    return Container(
      height: 460,
      width: double.infinity,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/icons/qr_code.png', width: 100),
                const SizedBox(height: 10),
                Text(
                  'Tash Clean',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                DottedLine(
                  dashColor: primaryColor,
                  dashGapRadius: 10,
                  lineThickness: 2,
                ),
                gap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Id pesanan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Id12345',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Customer',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal Pesanan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '01-01-1999',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal Selesai',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '01-01-1999',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                gap,
                DottedLine(
                  dashColor: primaryColor,
                  dashGapRadius: 10,
                  lineThickness: 2,
                ),
                gap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cuci + Setrika',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Berat',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '5 kg',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                gap,
                DottedLine(
                  dashColor: primaryColor,
                  dashGapRadius: 10,
                  lineThickness: 2,
                ),
                gap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Biaya Jasa',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Rp. xx.xxx,-',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Biaya Pengiriman',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Rp. 0,-',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Rp. xx.xxx,-',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan Pembayaran',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Rp. xx.xxx,-',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                gap,
                DottedLine(
                  dashColor: primaryColor,
                  dashGapRadius: 10,
                  lineThickness: 2,
                ),
                const SizedBox(height: 15),
                Text(
                  'Terima Kasih',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfColor primaryColor = const PdfColor.fromInt(0xff2E4374);
    PdfColor secondaryColor = const PdfColor.fromInt(0xFFDAF4FE);
    PdfColor errorColor = const PdfColor.fromInt(0xFFC53232);
    PdfColor successColor = const PdfColor.fromInt(0xFF8AB882);

    final pdf = pw.Document();
    final pw.MemoryImage logo = await loadImage('assets/images/Tash_Laundry.png');
    final pw.MemoryImage landscape = await loadImage('assets/icons/tash_landscape.png');
    final pw.MemoryImage qrcode = await loadImage('assets/icons/qr_code.png');

    final page = pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(width: 70, child: pw.Image(logo)),
                    pw.Container(
                      child: pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Tash Clean',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: primaryColor,
                              ),
                            ),
                            pw.Text(
                              'Jl. XXXX No. xx',
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Container(
                  width: 100,
                  child: pw.Image(qrcode)
                )
              ],
            ),
            pw.SizedBox(height: 25),
            pw.Table(
              children: [
                pw.TableRow(
                  children: [
                    pw.Container(
                      child: pw.Text(
                        'ID Pesanan',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor
                        ),
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                          ': ID-012345',
                          style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: primaryColor
                          ),
                        )
                    ),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      child: pw.Text(
                        'Nama Customer',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                          ': John Doe',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        )
                    ),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      child: pw.Text(
                        'Tanggal Pesanan',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      child: pw.RichText(
                        text: pw.TextSpan(
                          children: <pw.TextSpan>[
                            pw.TextSpan(
                              text: ': ',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold
                              )
                            ),
                            pw.TextSpan(
                              text: '01-01-2021',
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ]
                        )
                      )
                    ),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      child: pw.Text(
                        'Tanggal Selesai',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                        child: pw.RichText(
                            text: pw.TextSpan(
                                children: <pw.TextSpan>[
                                  pw.TextSpan(
                                      text: ': ',
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.bold
                                      )
                                  ),
                                  pw.TextSpan(
                                    text: '04-01-2021',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ]
                            )
                        )
                    ),
                    pw.Container(child: pw.Text('####################', style: pw.TextStyle(color: PdfColors.white))),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              children: [
                pw.TableRow(
                  children: [
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: primaryColor,
                            child: pw.Text(
                              'Layanan',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xFFFFFFFF)
                              ),
                            )
                        )
                    ),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: primaryColor,
                            child: pw.Text(
                              'Berat',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xFFFFFFFF)
                              ),
                            )
                        )
                    ),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: primaryColor,
                            child: pw.Text(
                              'Subtotal',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xFFFFFFFF)
                              ),
                            )
                        )
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: secondaryColor,
                            child: pw.Text(
                              'Cuci + Setrika',
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            )
                        )
                    ),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: secondaryColor,
                            child: pw.Text(
                              '5 kg',
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            )
                        )
                    ),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.center,
                            color: secondaryColor,
                            child: pw.Text(
                              'Rp. 20.000,-',
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            )
                        )
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: primaryColor)
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Biaya Jasa :',
                                  style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ),
                                ),
                                pw.Text(
                                  'Rp. 16.000,-',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ],
                ),

                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: primaryColor)),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Biaya Pengiriman :',
                                  style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ),
                                ),
                                pw.Text(
                                  'Rp. 4.000,-',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(),
                    pw.Container(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(child: pw.Container(padding: const pw.EdgeInsets.all(5))),
                    pw.Container(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                                color: errorColor
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Tagihan Pembayaran :',
                                  style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: const PdfColor.fromInt(0xFFFFFFFF)
                                  ),
                                ),
                                pw.Text(
                                  'Rp. 2.000,-',
                                  style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xFFFFFFFF)
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
            pw.SizedBox(height: 35),
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              color: successColor,
              alignment: pw.Alignment.center,
              child: pw.Text(
                'LUNAS',
                style: pw.TextStyle(
                    color: const PdfColor.fromInt(0xFFFFFFFF),
                    fontWeight: pw.FontWeight.bold
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Center(
             child: pw.Text(
               'Terima kasih telah menggunakan aplikasi Tash Clean.',
               style: pw.TextStyle(
                   fontWeight: pw.FontWeight.bold,
                   fontSize: 18,
                   color: primaryColor
               ),
             ),
            )
          ],
        );
      },
    );

    pdf.addPage(page);

    final Uint8List bytes = await pdf.save();
    await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

  Future<pw.MemoryImage> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return pw.MemoryImage(data.buffer.asUint8List());
  }
}
