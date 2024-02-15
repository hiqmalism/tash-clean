import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import 'package:tash_clean/login.dart';
import 'package:tash_clean/otp.dart';
import 'package:tash_clean/style.dart';



class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController tokoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late EmailAuth emailAuth;

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
    final String apiUrl = "http://localhost/api/tashclean/register.php";

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
        // Handle registration failure
      }
    } catch (error) {
      print("Error during registration: $error");
      // Handle other errors
    }
  }

  Future<void> sendOtp() async {
    try {
      final response = await http.post(Uri.parse('http://localhost/api/tashclean/verifotp.php'),
          body: jsonEncode({
            'email': emailController.text,
          }
          )
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp Sent'),
          ),
        );
        print('before');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPPage(email: emailController.text)),
        );
        print('after');
      } else {
        print('Failed to send OTP');
        print(response.body);
      }
    } catch (error) {
      print('Error : $error');
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
          controller: emailController,
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
          controller: teleponController,
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
          controller: namaController,
          label: 'Nama Lengkap',
          hintText: 'Masukkan Nama',
          validator: validateFullName,
          onSaved: (String? val) {
            _namalengkap = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          controller: tokoController,
          label: 'Nama Toko',
          hintText: 'Masukkan Nama Laundry',
          validator: validateStoreName,
          onSaved: (String? val) {
            _namalaundry = val;
          },
        ),
        const SizedBox(height: 20),
        buildInputField(
          controller: passwordController,
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
        Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: ElevatedButton(
            onPressed: _validateInputs,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Text(
              'Daftar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Divider(
                height: 3,
                color: primaryColor,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Text("atau", style: TextStyle(color: primaryColor)),
            Expanded(
              child: Divider(
                height: 3,
                color: primaryColor,
                indent: 10,
                endIndent: 10,
              ),
            ),
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text('Masuk',
                  style: TextStyle(
                    color: tertiaryColor,
                    fontWeight: FontWeight.bold,
                  )
              ),
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
    required TextEditingController controller
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tertiaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
            errorStyle: TextStyle(
                color: errorColor
            ),
            fillColor: offColor,
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
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tertiaryColor
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onSaved: onSaved,
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