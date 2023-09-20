import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tenantyia/screens/detailtenant.dart';
import 'package:tenantyia/screens/inputdata.dart';
import 'package:tenantyia/screens/menu.dart';
import 'package:tenantyia/services/dbtenantservices.dart';

class TenantListScreen extends StatelessWidget {
  final Database tenantService = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commercial Departement'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot dsData = snapshot.data!.docs[index];
                String lvnamaPT = dsData['NamaPT'];
                String lvGerai = dsData['Gerai'];
                String lvLokasi = dsData['Lokasi'];
                String lvGambar = dsData['Gambar'];
                String documentId = dsData.id; // Dapatkan ID dokumen

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(documentId: documentId),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        lvGambar, // URL gambar dari Firestore
                      ),
                      radius: 30,
                    ),
                    title: Text(
                      lvnamaPT,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '$lvGerai - $lvLokasi',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Tambahkan aksi ketika tombol delete ditekan
                        _confirmDelete(context, dsData.id);
                      },
                    ),
                    // Anda juga dapat menambahkan widget lainnya sesuai kebutuhan di sini
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blueAccent,
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Anda yakin ingin menghapus item ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                // Hapus data saat pengguna mengkonfirmasi
                await Database.hapusData(documentId);

                // Ganti rute ke layar daftar tenant setelah penghapusan
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => const MyHomePage(),
                //   ),
                // );
                Navigator.of(context).pop(); // Tutup dialog
                final snackbar = SnackBar(
                  content: Text('Berhasil Menghapus data'),
                  backgroundColor: Colors.redAccent,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
