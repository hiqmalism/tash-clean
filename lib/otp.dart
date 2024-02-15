import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tash_clean/style.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';

// void main() {
//   runApp(new MaterialApp(
//     title: "My Apps",
//     home: new OTPPage(),
//   )
//   );
// }

class OTPPage extends StatefulWidget {
  final String email;

  OTPPage({required this.email});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List<TextEditingController> otpControllers = List.generate(
      6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(
      6, (index) => FocusNode());
  bool isOTPCorrect = true;
  int countdown = 60;
  late Timer timer;
  String formattedTime = '';
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    final String apiUrl = "http://localhost/api-tashclean/verifotp.php";
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": widget.email,
        "otp": otpControllers.map((controller) => controller.text).join(),
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      // Handle response dari verifikasi OTP di sini
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(() {
          if (countdown < 0) {
            timer.cancel();
          } else {
            int minutes = countdown ~/ 60;
            int seconds = countdown % 60;

            // Mengonversi nilai detik menjadi format menit:detik
            formattedTime =
            '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(
                2, '0')}';
            countdown--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ta3.png',
                width: 90.0, height: 90.0, fit: BoxFit.fill),
            const SizedBox(height: 15.0),
            Text('VERIFIKASI',
                style: TextStyle(
                  color: Color(0xFF2E4374),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 0,)),
            Text(
              'Inputkan Kode OTP yang telah dikirimkan ke Email Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2E4374),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Kode OTP',
                  labelStyle: TextStyle(
                    color: Color(0xFF2E4374),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: countdown == 0 ? () => resendOTP() : null,
                child: Text(
                  countdown == 0 ? 'Kirim Ulang Kode' : formattedTime,
                  style: TextStyle(fontSize: 12, color: primaryColor),),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                    (index) =>
                    Container(
                      width: 40,
                      height: 40,
                      // padding: EdgeInsets.all(5),
                      // decoration: ShapeDecoration(
                      //     color: Color(0x7FE6E5E5),
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))
                      // ),
                      child: TextFormField(
                        controller: otpControllers[index],
                        focusNode: otpFocusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: Color(0x7FE6E5E5),
                          counterText: '',
                          errorText: !isOTPCorrect ? 'OTP salah' : null,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isOTPCorrect
                                  ? Colors.transparent
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          // border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isOTPCorrect
                                  ? Colors.transparent
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).requestFocus(
                                otpFocusNodes[index + 1]);
                          }
                          setState(() {
                            isOTPCorrect = true;
                          }
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harus diisi';
                          }
                          return null;
                        },
                      ),
                    ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 135,
              height: 35,
              child: ElevatedButton(
                child: Text(
                  'Verifikasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)))
                ),
                onPressed: () {
                  verifyOTP();
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     verifyOTP();
            //   },
            //   child: Text('Verifikasi'),
            // ),
          ],
        ),
      ),
    );
  }

  void resendOTP() {
    // Implementasi pengiriman ulang OTP disini
    // Reset countdown dan timer
    setState(() {
      countdown = 60;
    });
    startCountdown();
  }

  void verifOTP() {
    String enteredOTP = otpControllers.map((controller) => controller.text)
        .join();
    // Implementasi verifikasi OTP disini

    if (enteredOTP.length == 6 && RegExp(r'^\d+$').hasMatch(enteredOTP)) {
      // Misalnya, membandingkan enteredOTP dengan OTP yang dikirim
      setState(() {
        isOTPCorrect = true;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verifikasi Berhasil!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        isOTPCorrect = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verifikasi Gagal'),
            content: Text('Masukkan OTP yang valid.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}