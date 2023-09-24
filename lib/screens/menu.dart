import 'package:flutter/material.dart';
import 'package:tenantyia/screens/informationpage.dart';
import 'package:tenantyia/screens/inputdata.dart';
import 'package:tenantyia/screens/listtenant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TenantListScreen(),
    DataInputForm(),
    InformationPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Warna latar belakang
        selectedItemColor: Colors.blueAccent, // Warna item yang dipilih
        unselectedItemColor: Colors.black54, // Warna item yang tidak dipilih
        iconSize: 30, // Ukuran ikon
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold), // Gaya label yang dipilih
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal), // Gaya label yang tidak dipilih
        elevation: 8, // Tinggi elevasi
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Tenant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_link_outlined),
            label: 'Add Tenant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_sharp),
            label: 'Information',
          ),
        ],
      ),
    );
  }
}
