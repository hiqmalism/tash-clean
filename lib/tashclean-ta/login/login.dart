import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tash_clean/tashclean-ta/screen/navigation.dart';
import 'dart:convert';
import 'package:tash_clean/tashclean-ta/login/register.dart';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  String? email;
  String? password;
  String? emailError;
  String? passwordError;

  final TextEditingController _passwordController = TextEditingController();

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      sendPostRequest();
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }

  Future<void> sendPostRequest() async {
    final String apiUrl = "http://192.168.1.20/API/tashclean/login.php";
    var response = await http.post(
      Uri.parse(apiUrl),
      // headers: {
      //   "Content-Type": "application/json",
      // },
      body: {
        "email": email,
        "password": password,
      },
    );
    print('Request body: ${jsonEncode({"email": email, "password": password})}');
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Response: $jsonResponse');
        if (jsonResponse['status'] == 'success') {
          print('Login successful');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Navigation(email: email, password: password, status: 'antrian', selectedPageIndex: 0)),
          );
        } else {
          setState(() {
            emailError = jsonResponse['message'] == 'Email not registered'
                ? 'Email tidak terdaftar'
                : null;

            passwordError = jsonResponse['message'] == 'Invalid password'
                ? 'Password tidak valid'
                : null;
          });
          print('Login failed: ${jsonResponse['message']}');
        }
      } catch (e) {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Error decoding JSON : $e');
      }
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: formUI(),
            ),
          ),
        ],
      ),
    );
  }

  Widget formUI() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/Tash_Laundry.png', height: 170),
          Text(
            'MASUK',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          EmailFormField(
            onSaved: (val) => email = val,
            errorText: emailError
          ),
          const SizedBox(height: 20),
          PasswordFormField(
            passwordController: _passwordController,
            onSaved: (val) => password = val,
              errorText: passwordError
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lupa Kata Sandi?',
                  style: TextStyle(
                    color: tertiaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                'Masuk',
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
                'Belum punya akun?',
                style: TextStyle(color: primaryColor),
              ),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationForm(),
                    ),
                  );
                },
                child: Text('Daftar',
                  style: TextStyle(
                    color: tertiaryColor,
                    fontWeight: FontWeight.bold
                  )
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmailFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? errorText;

  const EmailFormField({super.key, this.onSaved, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7,),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Masukkan Email',
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tertiaryColor
            ),
            errorText: errorText,
            filled: true,
            fillColor: offColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none
            ),
            errorStyle: TextStyle(
              color: errorColor
            ),
          ),
          style: TextStyle(
            color: tertiaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: onSaved,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
        ),
      ],
    );
  }
}

class PasswordFormField extends StatefulWidget {
  final TextEditingController passwordController;
  final void Function(String?)? onSaved;
  final String? errorText;

  const PasswordFormField({
    super.key,
    required this.passwordController,
    this.onSaved,
    this.errorText
  });

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor
          ),
        ),
        const SizedBox(height: 7,),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Masukkan Password',
            hintStyle: TextStyle(
              color: tertiaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            errorText: widget.errorText,
            filled: true,
            fillColor: offColor,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                color: tertiaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none
            ),
            errorStyle: TextStyle(
              color: errorColor
            ),
          ),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: tertiaryColor
          ),
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          validator: validatePassword,
          onSaved: widget.onSaved,
          controller: widget.passwordController,
          onEditingComplete: () {
            FocusScope.of(context).unfocus(); // Sembunyikan keyboard
          },
        ),
      ],
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  if (!regex.hasMatch(value)) {
    return 'Email tidak valid';
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