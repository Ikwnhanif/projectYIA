import 'package:flutter/material.dart';
import 'package:tenantyia/data/shared_pref.dart';
import 'package:tenantyia/screens/loginpage.dart';

class InformationPage extends StatelessWidget {
  // Metode untuk menampilkan dialog konfirmasi logout
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Anda yakin ingin keluar dari akun Anda?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                SharedPref().setLogout();
                final snackbar = SnackBar(
                  content: Text('Berhasil Logout'),
                  backgroundColor: Colors.redAccent,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
        actions: [
          // Tambahkan AlertDialog setelah diklik ikon logout
          IconButton(
            onPressed: () {
              // Panggil metode untuk menampilkan dialog konfirmasi logout
              _showLogoutConfirmationDialog(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo YIA
              Image.network(
                'https://yogyakarta-airport.co.id/frontend/uploads/defaults/MpuklX20190503080722.png',
              ),
              SizedBox(height: 16),

              // Logo AP Corp (Logo kedua)
              Image.network(
                'https://ap1.co.id/contents/logo/large/ori-logo-ap-corp.png',
              ),
              SizedBox(height: 16),

              // Deskripsi Aplikasi
              Text(
                'Deskripsi Aplikasi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Aplikasi ini adalah sebuah platform terhubung dengan realtime database menggunakan firebase untuk mengelola data perusahaan yang berada di Yogyakarta International Airport (YIA). Anda dapat menggunakan aplikasi ini untuk memasukkan, mengedit, dan melihat data perusahaan dengan mudah.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // Fungsi Aplikasi
              Text(
                'Fungsi Aplikasi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Menambah data perusahaan baru.\n'
                '2. Mengedit data perusahaan yang sudah ada.\n'
                '3. Melihat daftar perusahaan .',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
