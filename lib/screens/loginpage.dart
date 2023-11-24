import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tenantyia/data/shared_pref.dart';
import 'package:tenantyia/screens/inputdata.dart';
import 'package:tenantyia/screens/listtenant.dart';
import 'package:tenantyia/screens/menu.dart';
import 'package:tenantyia/screens/registerpage.dart';
import 'package:tenantyia/services/user_database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Username_controller = TextEditingController();
  var Password_controller = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
  }

  void _checkLoginStatus() {
    SharedPref().getLoginStatus().then((status) {
      if (status) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              SizedBox(height: 120),
              const Text(
                "Commercial Departement",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 60),
              _formSection(Username_controller, 'Username'),
              SizedBox(height: 30),
              _formSectionPass(Password_controller, 'Password'),
              SizedBox(height: 50),
              _buttonSubmit(),
              SizedBox(height: 20),
              _buttonRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSection(dynamic textController, String label) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.people_rounded),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Wajib Diisi';
        }
        return null;
      },
    );
  }

  Widget _formSectionPass(dynamic textController, String label) {
    return TextField(
      controller: textController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient:
            const LinearGradient(colors: [Colors.blueAccent, Colors.black38]),
      ),
      child: MaterialButton(
        onPressed: _loginProcess,
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient:
            const LinearGradient(colors: [Colors.blueAccent, Colors.black38]),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: const Text(
          "Register",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _loginProcess() {
    String username = Username_controller.text;
    String password = Password_controller.text;
    if (Username_controller.text != "" && Password_controller.text != "") {
      _onLogin();
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("Tidak Boleh Ada Yang Kosong"),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _onLogin() async {
    try {
      await UserDatabaseHelper.getUserByUsernameAndPassword(
          Username_controller.text, Password_controller.text);
      SharedPref().setLogin(Username_controller.text);
      final snackbar = SnackBar(
        content: Text('Berhasil Login'),
        backgroundColor: Colors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } catch (e) {
      final snackbar = SnackBar(
        content: Text('Username atau Password Salah'),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
