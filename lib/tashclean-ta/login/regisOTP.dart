import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import 'package:tash_clean/tashclean-ta/login/verifikasiOTP.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VERIFIKASI',
      theme: ThemeData(),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  TextEditingController emailController = TextEditingController();
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = EmailAuth(
      sessionName: "Sample session",
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? _email;
  String? _noHP;
  String? _namalengkap;
  String? _namalaundry;
  String? _password;
  String? _foto;

  void _validateInputs() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await sendPostRequest();
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }

  Future<void> sendPostRequest() async {
    final String apiUrl = "http://192.168.1.20/api/tashclean/create.php";

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "nama_lengkap": _namalengkap,
            "nama_laundry": _namalaundry,
            "email": _email,
            "no_hp": _noHP,
            "password": _password,
            "foto": _foto,
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Registration successful!");
        print(response.body);
        sendOtp();
      } else {
        print("Failed to register. Server responded with ${response.statusCode}");
        print(response.body); // Print the server's response for debugging
        // Handle registration failure
      }
    } catch (error) {
      print("Error during registration: $error");
      // Handle other errors
    }
  }


  void sendOtp() async {
    String recipientEmail = _email!;

    if (recipientEmail.isEmpty) {
      print('OTP Failed: Email is empty');
      return;
    }

    try {
      final String apiUrl = "http://192.168.1.20/api/tashclean/sendotp.php";

      var response = await http.post(
        Uri.parse(apiUrl),
        // headers: {"Content-Type": "application/json"},
        body: ({
          "email": recipientEmail,
        }),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseData = json.decode(response.body);

          bool otpStatus = responseData['status'];
          print('OTP Status: $otpStatus');

          if (otpStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP Sent'),
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OTPPage(email: recipientEmail)),
            );
          } else {
            print('Failed to send OTP');
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('Failed to send OTP. Server responded with ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error during OTP sending: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/Tash_Laundry.png', height: 170),
        Text(
          'REGISTRASI',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e4374),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 20),
        buildInputField(
          label: 'Email',
          hintText: 'Masukkan Email',
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String? val) {
            _email = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          label: 'Nomor Telepon',
          hintText: 'Masukkan Nomor Telepon',
          keyboardType: TextInputType.phone,
          validator: validatePhoneNumber,
          onSaved: (String? val) {
            _noHP = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          label: 'Nama Lengkap',
          hintText: 'Masukkan Nama',
          validator: validateFullName,
          onSaved: (String? val) {
            _namalengkap = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          label: 'Nama Toko',
          hintText: 'Masukkan Nama Laundry',
          validator: validateStoreName,
          onSaved: (String? val) {
            _namalaundry = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          label: 'Password',
          hintText: 'Masukkan Password',
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: validatePassword,
          onSaved: (String? val) {
            _password = val;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _validateInputs,
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0xff2e4374)),
          ),
          child: const Text('Daftar'),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Divider()),
            Text(
              "atau",
              style: TextStyle(
                color: Color(0xff2e4374),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sudah punya akun?',
              style: TextStyle(color: Color(0xff2e4374)),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInputField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xff2e4374),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xFF7C81AD),
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2e4374), width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xFFE7E6E6),
            filled: true,
            suffixIcon: obscureText
                ? IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            )
                : null,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
        ),
      ],
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!regex.hasMatch(value)) {
      return 'Masukkan Email Valid';
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Nomor Telepon tidak boleh kosong';
    }
    if (value.length < 11) {
      return 'Nomor Telepon tidak boleh kurang dari 11';
    } else {
      return null;
    }
  }

  String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 2) {
      return 'Nama tidak boleh kurang dari 2 karakter';
    } else {
      return null;
    }
  }

  String? validateStoreName(String? value) {
    if (value!.isEmpty) {
      return 'Nama Toko tidak boleh kosong';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    } else {
      return null;
    }
  }
}
