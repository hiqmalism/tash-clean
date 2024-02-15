import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import 'package:tash_clean/tashclean-ta/login/verifikasiBerhasil.dart';

class OTPPage extends StatefulWidget {
  final String email;

  OTPPage({required this.email});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  bool isOTPCorrect = true;
  int countdown = 60;
  late Timer timer;
  String formattedTime = '';

  Future<void> verifyOTP() async {
    final String apiUrl = "http://192.168.1.20/api/tashclean/emailotp.php";
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": widget.email,
          "otp": getEnteredOTP(),
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Verifikasi(),
          ),
        );
      } else {
        print(response.body);
        showErrorMessage("Failed to verify OTP. Please try again.");
      }
    } catch (e) {
      print(e);
      showErrorMessage("An error occurred. Please try again later.");
    }
  }

  String getEnteredOTP() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
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

            formattedTime =
            '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
            countdown--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
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
                child: Text(
                  'Kode OTP',
                  style: TextStyle(
                    color: Color(0xFF2E4374),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: countdown == 0 ? () => resendOTP() : null,
                child: Text(countdown == 0 ? 'Kirim Ulang Kode' : formattedTime, style: TextStyle(fontSize: 12, color: primaryColor),),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                    (index) => Container(
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
                      errorText: isOTPCorrect ? null : 'OTP salah',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isOTPCorrect ? Colors.transparent : Colors.red,
                          width: 2,
                        ),
                      ),
                      // border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isOTPCorrect ? Colors.transparent : Colors.red,
                          width: 2,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
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
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700,),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))
                ),
                onPressed: () {
                  verifOTP();
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

  // void verifOTP() {
  //   String enteredOTP = otpControllers.map((controller) => controller.text).join();
  //   // Implementasi verifikasi OTP disini
  //
  //   if (enteredOTP.length == 6 && RegExp(r'^\d+$').hasMatch(enteredOTP)) {
  //     // Misalnya, membandingkan enteredOTP dengan OTP yang dikirim
  //     setState(() {
  //       isOTPCorrect = true;
  //     });
  //     verifyOTP();
  //   } else {
  //     setState(() {
  //       isOTPCorrect = false;
  //     });
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Verifikasi Gagal'),
  //           content: Text('Masukkan OTP yang valid.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  void verifOTP() {
    String enteredOTP = getEnteredOTP();

    if (enteredOTP.length == 6 && RegExp(r'^\d+$').hasMatch(enteredOTP)) {
      setState(() {
        isOTPCorrect = true;
      });
      verifyOTP();
    } else {
      setState(() {
        isOTPCorrect = false;
      });
      showInvalidOTPDialog();
    }
  }

  void showInvalidOTPDialog() {
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