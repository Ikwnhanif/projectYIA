import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenantyia/screens/detailtenant.dart';
import 'package:tenantyia/screens/inputdata.dart';
import 'package:tenantyia/services/dbtenantservices.dart';

class TenantListScreen extends StatefulWidget {
  @override
  _TenantListScreenState createState() => _TenantListScreenState();
}

class _TenantListScreenState extends State<TenantListScreen> {
  late TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commercial Departement'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchTenantDelegate(),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
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
                String lvlastupdated = dsData['LastUpdated'];
                String lvGambar = dsData['Gambar'];
                String documentId = dsData.id;

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
                        lvGambar,
                      ),
                      radius: 30,
                    ),
                    title: Text(
                      '$lvnamaPT - $lvGerai',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Terakhir Diubah $lvlastupdated',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _confirmDelete(context, dsData.id);
                      },
                    ),
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
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await Database.hapusData(documentId);
                Navigator.of(context).pop();
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

class SearchTenantDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.searchData(
          query), // Menggunakan fungsi pencarian di Firebase
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot dsData = snapshot.data!.docs[index];
              String lvnamaPT = dsData['NamaPT'];
              String lvGerai = dsData['Gerai'];
              String lvlastupdated = dsData['LastUpdated'];
              // String lvLokasi = dsData['Lokasi'];
              String lvGambar = dsData['Gambar'];
              String documentId = dsData.id;

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
                      lvGambar,
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    '$lvnamaPT - $lvGerai',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Terakhir Diubah $lvlastupdated',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, dsData.id);
                    },
                  ),
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
