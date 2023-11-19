import 'package:flutter/material.dart';
import 'package:tenantyia/data/shared_pref.dart';
import 'package:tenantyia/screens/loginpage.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Metode untuk menampilkan dialog bantuan
  Future<void> _showHelpDialog(BuildContext context) async {
    TextEditingController _helpMessageController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Butuh Bantuan?'),
          content: Column(
            children: [
              Text(
                'Masukkan pesan bantuan Anda:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _helpMessageController,
                decoration: InputDecoration(
                  hintText: 'Pesan Bantuan',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Kirim pesan bantuan ke WhatsApp
                      _sendWhatsAppMessage(_helpMessageController.text);
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                    child: Text('Kirim Pesan Bantuan'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Metode untuk mengirim pesan ke WhatsApp
  void _sendWhatsAppMessage(String message) async {
    String phoneNumber =
        '+6285747950721'; // Ganti dengan nomor WhatsApp yang dituju

    String url =
        'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
        actions: [
          // Tombol Logout
          IconButton(
            onPressed: () {
              // Panggil metode untuk menampilkan dialog konfirmasi logout
              _showLogoutConfirmationDialog(context);
            },
            icon: Icon(Icons.logout),
          ),
          // Tombol Bantuan
          IconButton(
            onPressed: () {
              // Panggil metode untuk menampilkan dialog bantuan
              _showHelpDialog(context);
            },
            icon: Icon(Icons.help),
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
              SizedBox(height: 30),

              // Deskripsi Aplikasi
              Text(
                'Deskripsi Aplikasi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Aplikasi ini adalah sebuah platform terhubung dengan realtime database menggunakan firebase untuk mengelola data perusahaan yang berada di Yogyakarta International Airport (YIA). Anda dapat menggunakan aplikasi ini untuk memasukkan, mengedit, dan melihat data perusahaan dengan mudah.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  '1. Menambah data perusahaan baru.\n'
                  '2. Mengedit data perusahaan yang sudah ada.\n'
                  '3. Melihat dan Mencari daftar perusahaan.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
