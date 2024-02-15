import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import 'package:tash_clean/tashclean-ta/login/login.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';
import 'package:tash_clean/tashclean-ta/login/verifikasiOTP.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _obscureText = true;
  late EmailAuth emailAuth;

  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController tokoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    final String apiUrl = "http://192.168.1.20/api/tashclean/registrasi.php";

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
            "foto": _foto.toString(),
          }
        ),
      );

      if (response.statusCode == 200) {
        print("Registration successful!");
        print(response.body);

        final Map<String, dynamic> responseData = json.decode(response.body);
        bool registrationSuccess = responseData['registration_success'] ?? false;

        if (registrationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration successful! OTP Sent'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OTPPage(email: _email!)),
          );
        } else {
          print("Failed to register.");
          showErrorMessage("Failed to register. Please try again.");
        }
      } else {
        print("Failed to register. Server responded with ${response.statusCode}");
        showErrorMessage("Failed to register. Please try again.");
      }
    } catch (error) {
      print("Error during registration: $error");
      showErrorMessage("An error occurred. Please try again later.");
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
            color: primaryColor,
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
          isPassword: true,
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
            Text(
              'Sudah punya akun?',
              style: TextStyle(color: primaryColor),
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
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    required TextEditingController controller,
    void Function(String?)? onChanged,
    bool isPassword = false,
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
              borderSide: BorderSide.none,
            ),
            errorStyle: TextStyle(color: errorColor),
            fillColor: offColor,
            filled: true,
            suffixIcon: isPassword
              ? InkWell(
              onTap: () {
                setState(() {
                  if (isPassword) {
                    _obscureText = !_obscureText;
                  }
                });
              },
              child: Icon(
                isPassword && _obscureText
                    ? CupertinoIcons.eye
                    : CupertinoIcons.eye_slash,
                color: tertiaryColor,
              ),
            )
                : null,
          ),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: tertiaryColor,
          ),
          keyboardType: keyboardType,
          obscureText: isPassword ? _obscureText : false,
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

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: errorColor,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

