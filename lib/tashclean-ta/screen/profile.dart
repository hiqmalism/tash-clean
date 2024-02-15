import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tash_clean/tashclean-ta/login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:tash_clean/tashclean-ta/screen/style.dart';

class MyProfile extends StatefulWidget {
  String? email;
  String? nama;
  String? noHp;
  String? password;
  MyProfile({super.key, this.email, this.nama, this.noHp, this.password});

  factory MyProfile.fromJson(Map<String, dynamic> json) {
    return MyProfile(
      email: json['email'] as String?,
      nama: json['nama_lengkap'] as String?,
      noHp: json['no_hp']?.toString(),
      password: json['password'] as String?,
    );
  }

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<MyProfile> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.20/api/tashclean/readprofile.php?email=${Uri.encodeComponent(widget.email ?? '')}"),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> data = responseData[0];
          return MyProfile.fromJson(data);
        } else {
          print('Unexpected response format: $responseData');
          return MyProfile();
        }
      } else {
        // Handle errors
        print('Failed to load user data. Status code: ${response.statusCode}');
        return MyProfile();
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return MyProfile();
    }
  }




  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          height: 170,
          child: Column(
            children: [
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: primaryColor,
                  ),
                  title: Text('Galeri',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryColor
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      _updateSelectedImage(File(pickedFile.path));
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.camera_fill,
                    color: primaryColor,
                  ),
                  title: Text('Kamera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 16
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      _updateSelectedImage(File(pickedFile.path));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedImage(File selectedImage) {
    setState(() {
      _selectedImage = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fill,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Text('Profil',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white
              ),
            ),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            )
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder<MyProfile>(
              future: fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final userProfile = snapshot.data;
                  if (userProfile != null) {
                    return profilePage(userProfile);
                  } else {
                    return Text('No data available');
                  }
                }
              },
            )
          ),
        ),
      ),
    );
  }

  Widget profilePage(MyProfile userProfile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 85),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                ListTile(
                  leading:
                  Icon(CupertinoIcons.person_crop_circle, color: primaryColor, size: 30,),
                  subtitle: TextFormField(
                    readOnly: true,
                    initialValue: userProfile.nama ?? '',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor))
                    ),
                  ),
                  title: Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: primaryColor),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading:
                  ImageIcon(
                    AssetImage('assets/icons/email.png'),
                    color: primaryColor,
                  ),
                  subtitle: TextFormField(
                    readOnly: true,
                    initialValue: '${widget.email}',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor))
                    ),
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading:
                  ImageIcon(
                    AssetImage('assets/icons/phone.png'),
                    color: primaryColor,
                  ),
                  subtitle: TextFormField(
                    readOnly: true,
                    initialValue: userProfile.noHp ?? '',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor))
                    ),
                  ),
                  title: Text(
                    'No Telepon',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: primaryColor),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading:
                  ImageIcon(
                    AssetImage('assets/icons/padlock.png'),
                    color: primaryColor,
                  ),
                  subtitle: TextFormField(
                    readOnly: true,
                    obscureText: true,
                    initialValue: widget.password,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor))
                    ),
                  ),
                  title: Text(
                    'Kata Sandi',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: primaryColor),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 30,
                  width: 120,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 15,
                    ),
                    label: Text(
                      'Keluar',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(errorColor),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -485, 0),
            child: InkWell(
              onTap: () {
                _showImagePickerModal(context);
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor,
                    child: _selectedImage != null
                        ? ClipOval(
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ))
                        : Icon(
                      CupertinoIcons.person_crop_circle,
                      size: 90, color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: IconButton(
                        onPressed: () {
                          _showImagePickerModal(context);
                        },
                        icon: Icon(Icons.camera_alt, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}