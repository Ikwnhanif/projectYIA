import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenantyia/screens/editform.dart';
import 'package:tenantyia/screens/inputdata.dart';
import 'package:tenantyia/screens/petayia.dart'; // Impor halaman Form Input

class DetailPage extends StatefulWidget {
  final String documentId;

  DetailPage({required this.documentId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('dataTenant') //koleksi Firestore Anda
        .doc(widget.documentId) // Gunakan documentId yang diterima dari widget
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tenant'),
        actions: [
          IconButton(
            onPressed: () {
              // Panggil metode untuk menampilkan gambar
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapsYIA()));
            },
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Data not found'),
            );
          }

          // mengakses data dari snapshot.data
          String lvnamaPT = snapshot.data!['NamaPT'];
          String lvGerai = snapshot.data!['Gerai'];
          String lvLokasi = snapshot.data!['Lokasi'];
          String lvGambar = snapshot.data!['Gambar'];
          String lvKode = snapshot.data!['Kode'];
          String lvLuas = snapshot.data!['Luas'];
          String lvKeterangan = snapshot.data!['Keterangan'];
          String lvJenis = snapshot.data!['Jenis'];
          String lvKondisi = snapshot.data!['Kondisi'];
          String lvLastUpdated = snapshot.data!['LastUpdated'];

          return ListView(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(lvGambar), // URL gambar dari Firestore
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Nama Perusahaan'),
                subtitle: Text(lvnamaPT),
              ),
              ListTile(
                title: Text('Nama Gerai'),
                subtitle: Text(lvGerai),
              ),
              ListTile(
                title: Text('Lokasi'),
                subtitle: Text(lvLokasi),
              ),
              ListTile(
                title: Text('Kode'),
                subtitle: Text(lvKode),
              ),
              ListTile(
                title: Text('Jenis'),
                subtitle: Text(lvJenis),
              ),
              ListTile(
                title: Text('Luas'),
                subtitle: Text(lvLuas + " m²"),
              ),
              ListTile(
                title: Text('Kondisi'),
                subtitle: Text(lvKondisi),
              ),
              ListTile(
                title: Text('Terakhir Diupdate'),
                subtitle: Text(lvLastUpdated),
              ),
              ListTile(
                title: Text('Keterangan'),
                subtitle: Text(lvKeterangan),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditForm(
                  documentId: widget.documentId, // Kirim documentId ke EditForm
                ),
              ),
            );
          },
          child: Text('Update Data'),
        ),
      ),
    );
  }
}
