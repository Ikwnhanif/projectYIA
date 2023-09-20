import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenantyia/models/datatenant.dart';
import 'package:tenantyia/screens/listtenant.dart';
import 'package:tenantyia/screens/menu.dart';
import 'package:tenantyia/services/dbtenantservices.dart';

class DataInputForm extends StatefulWidget {
  @override
  _DataInputFormState createState() => _DataInputFormState();
}

class _DataInputFormState extends State<DataInputForm> {
  String selectedBusinessType = 'Food And Beverage'; // Default jenis usaha
  String selectedLocation = 'Check In Area'; // Default lokasi

  var namaPT = TextEditingController();
  var gerai = TextEditingController();
  var luas = TextEditingController();
  var keterangan = TextEditingController();
  var kode = TextEditingController();
  var linklogo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Perusahaan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.business, size: 24), // Ikon perusahaan
                  SizedBox(width: 8.0),
                  Text(
                    'Nama Perusahaan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: namaPT,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama perusahaan',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.shopping_bag, size: 24), // Ikon gerai
                  SizedBox(width: 8.0),
                  Text(
                    'Nama Gerai (Brand)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: gerai,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama gerai (brand)',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.code, size: 24), // Ikon gerai
                  SizedBox(width: 8.0),
                  Text(
                    'Kode Ruang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: kode,
                decoration: InputDecoration(
                  hintText: 'Masukkan Kode Ruangan',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.business_center, size: 24), // Ikon jenis usaha
                  SizedBox(width: 8.0),
                  Text(
                    'Jenis Usaha',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedBusinessType,
                onChanged: (newValue) {
                  setState(() {
                    selectedBusinessType = newValue!;
                  });
                },
                items: <String>[
                  'Food And Beverage',
                  'Service',
                  'Retail',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.location_on, size: 24), // Ikon lokasi
                  SizedBox(width: 8.0),
                  Text(
                    'Lokasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                  });
                },
                items: <String>[
                  'Check In Area',
                  'Kedatangan',
                  'Keberangkatan',
                  'Kawasan Tugu Malioboro',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.square_foot, size: 24), // Ikon luas bangunan
                  SizedBox(width: 8.0),
                  Text(
                    'Luas Bangunan (m)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: luas,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Masukkan luas bangunan',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.description, size: 24), // Ikon keterangan
                  SizedBox(width: 8.0),
                  Text(
                    'Keterangan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: keterangan,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Masukkan keterangan',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.image, size: 24), // Ikon gambar
                  SizedBox(width: 8.0),
                  Text(
                    'Gambar Logo Brand',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // TextFormField(
              //   controller: linklogo,
              //   decoration: InputDecoration(
              //     hintText: 'Masukkan Link gambar',
              //   ),
              // ),
              InkWell(
                onTap: () {
                  _pickImage(); // Memanggil pemilihan gambar dari galeri
                },
                child: Container(
                  height: 80.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(8.0), // Mengatur radius sudut
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 140, 140)),
                    color: Color.fromARGB(255, 201, 201, 201), // Warna abu-abu
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 24,
                      ), // Ikon kamera
                      SizedBox(width: 8.0),
                      Text(
                        'Pilih Gambar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 113, 113, 113),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (namaPT.text.isNotEmpty &&
                        gerai.text.isNotEmpty &&
                        selectedBusinessType.isNotEmpty &&
                        selectedLocation.isNotEmpty &&
                        luas.text.isNotEmpty &&
                        keterangan.text.isNotEmpty &&
                        linklogo.text.isNotEmpty) {
                      _onSubmit();
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text("Tidak Boleh Ada Yang Kosong"),
                        backgroundColor: Colors.redAccent,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Warna tombol
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('Simpan Data', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        linklogo.text = pickedFile.path; // Menggunakan path gambar yang dipilih
      });
    }
  }

  Future<void> _uploadImage() async {
    if (linklogo.text.isNotEmpty) {
      try {
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final UploadTask uploadTask = storageRef.putFile(File(linklogo.text));

        await uploadTask.whenComplete(() async {
          String imageUrl = await storageRef.getDownloadURL();
          // Simpan URL gambar ke Firestore bersama data lainnya
          _onSubmitWithImage(imageUrl);
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  void _onSubmitWithImage(String imageUrl) async {
    // Membuat objek dataTenant dari input pengguna
    dataTenant _dataTenant = dataTenant(
      itemNamaPT: namaPT.text,
      itemGerai: gerai.text,
      itemLokasi: selectedLocation,
      itemJenis: selectedBusinessType,
      itemLuas: luas.text,
      itemKeterangan: keterangan.text,
      itemKode: kode.text,
      itemGambar: imageUrl, // Menggunakan URL gambar
    );

    try {
      // Menambahkan data ke Firestore menggunakan metode tambahData
      await Database.tambahData(item: _dataTenant);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
      final snackbar = SnackBar(
        content: Text('Berhasil Menambah data'),
        backgroundColor: Colors.greenAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      final snackbar = SnackBar(
        content: Text('Gagal Menambah data'),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void _onSubmit() async {
    if (linklogo.text.isNotEmpty) {
      _uploadImage(); // Upload gambar sebelum menyimpan data
    } else {
      _onSubmitWithImage(''); // Jika tidak ada gambar, gunakan string kosong
    }
  }
}
