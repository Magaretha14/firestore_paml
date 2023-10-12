import 'package:firestore_db/controller/auth_controller.dart';
import 'package:firestore_db/model/user_model.dart';
import 'package:firestore_db/view/login.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final formkey = GlobalKey<FormState>();

  final authCr = AuthController();

  ///Fungsi untuk tampilan register
  @override
  Widget build(BuildContext context) {
    String? name;
    String? email;
    String? password;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                /// Input untuk nama pengguna
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),

                /// Input untuk alamat email
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),

                /// Input untuk kata sandi (diberikan obscureText untuk menyembunyikan)
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),

                /// Tombol untuk melakukan pendaftaran
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      /// Melakukan pendaftaran dengan email, kata sandi, dan nama
                      UserModel? registeredUser =
                          await authCr.registerWithEmailAndPassword(
                              email!, password!, name!);

                      if (registeredUser != null) {
                        /// Tampilan pesan sukses jika pendaftaran berhasil
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Successful'),
                              content: const Text(
                                  'You have been successfully registered.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    /// Navigasi kembali ke halaman login setelah pendaftaran sukses
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Login();
                                    }));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        /// Tampilan pesan gagal jika pendaftaran gagal
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
                              content: const Text(
                                  'An error occurred during registration.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Register'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
