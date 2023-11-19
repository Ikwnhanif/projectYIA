import 'package:flutter/material.dart';
import 'package:tenantyia/models/akun.dart';
import 'package:tenantyia/screens/loginpage.dart';
import 'package:tenantyia/services/user_database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  var Username = TextEditingController();
  var Password = TextEditingController();
  var CPassword = TextEditingController();
  var KodeAngkasapura1 =
      TextEditingController(); // Tambahkan controller untuk kode angkasapura1

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: Username,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.people_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib Diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: Password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Wajib Diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: CPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi Password Wajib Diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: KodeAngkasapura1,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Kode Angkasapura1",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.security),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib Diisi';
                      } else if (value != "commercial1") {
                        return 'Kode yang dimasukkan salah';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.black38]),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (Username.text != "" &&
                              Password.text != "" &&
                              CPassword.text != "") {
                            if (Password.text != CPassword.text) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    "Password dan Konfirmasi Password harus sama!"),
                                backgroundColor: Colors.redAccent,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              _onRegister();
                            }
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("Tidak Boleh Ada Yang Kosong"),
                              backgroundColor: Colors.redAccent,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }),
                        );
                      },
                      child: Text(
                        "Kembali menu Login",
                        style: TextStyle(color: Colors.black54),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() async {
    Akun akun = Akun(Username.text, Password.text);
    try {
      await UserDatabaseHelper.createUser(akun);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }),
      );
      final snackbar = SnackBar(
        content: Text('Berhasil Membuat Akun'),
        backgroundColor: Colors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      final snackbar = SnackBar(
        content: Text('Gagal Membuat Akun'),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
