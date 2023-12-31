import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditForm extends StatefulWidget {
  final String documentId;

  EditForm({required this.documentId});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _namaPTController;
  late TextEditingController _geraiController;
  late TextEditingController _lokasiController;
  late TextEditingController _kodeController;
  late TextEditingController _jenisController;
  late TextEditingController _luasController;
  late TextEditingController _keteranganController;
  late TextEditingController _kondisiController;
  late TextEditingController _lastupdateController;

  String selectedBusinessType = 'Food And Beverage'; // Default jenis usaha
  String selectedLocation = 'Check In Area'; // Default lokasi
  String selectedkondisi = 'Sangat Baik'; // Default kondisi

  @override
  void initState() {
    super.initState();
    _namaPTController = TextEditingController();
    _geraiController = TextEditingController();
    _lokasiController = TextEditingController();
    _kodeController = TextEditingController();
    _jenisController = TextEditingController();
    _luasController = TextEditingController();
    _keteranganController = TextEditingController();
    _kondisiController = TextEditingController();
    _lastupdateController = TextEditingController();

    // Mengisi nilai awal dari Firestore berdasarkan widget.documentId
    _fetchData();
  }

  void _fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('dataTenant')
        .doc(widget.documentId)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _namaPTController.text = data['NamaPT'];
        _geraiController.text = data['Gerai'];
        _lokasiController.text = data['Lokasi'];
        _kodeController.text = data['Kode'];
        _jenisController.text = data['Jenis'];
        _luasController.text = data['Luas'];
        _keteranganController.text = data['Keterangan'];
        _kondisiController.text = data['Kondisi'];
        _lastupdateController.text = data['LastUpdated'];
      });
    }
  }

  @override
  void dispose() {
    _namaPTController.dispose();
    _geraiController.dispose();
    _lokasiController.dispose();
    _kodeController.dispose();
    _jenisController.dispose();
    _luasController.dispose();
    _keteranganController.dispose();
    _kondisiController.dispose();
    _lastupdateController.dispose();
    super.dispose();
  }

  void _updateData() async {
    // Mendapatkan waktu saat ini
    DateTime now = DateTime.now();

    // Memformat waktu ke dalam string yang sesuai
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'NamaPT': _namaPTController.text,
        'Gerai': _geraiController.text,
        'Lokasi': selectedLocation,
        'Kode': _kodeController.text,
        'Jenis': selectedBusinessType,
        'Luas': _luasController.text,
        'Keterangan': _keteranganController.text,
        'Kondisi': selectedkondisi,
        'LastUpdated': formattedDate,
      };

      await FirebaseFirestore.instance
          .collection('dataTenant')
          .doc(widget.documentId)
          .update(updatedData);

      Navigator.pop(context); // Kembali ke halaman DetailPage setelah update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tenant Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Perusahaan
                Row(
                  children: [
                    Icon(Icons.business, size: 24),
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
                  controller: _namaPTController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama perusahaan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harap masukkan nama perusahaan';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.0),

                // Nama Gerai
                Row(
                  children: [
                    Icon(Icons.shopping_bag, size: 24),
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
                  controller: _geraiController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama gerai (brand)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harap masukkan nama gerai';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.0),

                // Lokasi
                Row(
                  children: [
                    Icon(Icons.location_on, size: 24),
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
                // TextFormField(
                //   controller: _lokasiController,
                //   decoration: InputDecoration(
                //     hintText: 'Masukkan lokasi',
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Harap masukkan lokasi';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 14.0),

                // Kode
                Row(
                  children: [
                    Icon(Icons.code, size: 24),
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
                  controller: _kodeController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Kode Ruangan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harap masukkan kode';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.0),

                // Jenis
                Row(
                  children: [
                    Icon(Icons.business_center, size: 24),
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
                SizedBox(height: 14.0),

                // Luas
                Row(
                  children: [
                    Icon(Icons.square_foot, size: 24),
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
                  controller: _luasController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Masukkan luas bangunan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harap masukkan luas';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.0),
                // kondisi
                Row(
                  children: [
                    Icon(Icons.admin_panel_settings, size: 24),
                    SizedBox(width: 8.0),
                    Text(
                      'Kondisi Gerai',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedkondisi, // TOD
                  onChanged: (newValue) {
                    setState(() {
                      selectedkondisi = newValue!;
                    });
                  },
                  items: <String>[
                    'Sangat Baik',
                    'Baik',
                    'Buruk',
                    'Sangat Buruk',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 14.0),

                // Keterangan
                Row(
                  children: [
                    Icon(Icons.description, size: 24),
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
                  controller: _keteranganController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Masukkan keterangan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harap masukkan keterangan';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Tombol Simpan
                Center(
                  child: ElevatedButton(
                    onPressed: _updateData,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text('Simpan Perubahan',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
