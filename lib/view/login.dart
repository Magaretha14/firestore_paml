import 'package:firestore_db/controller/auth_controller.dart';
import 'package:firestore_db/model/user_model.dart';
import 'package:firestore_db/view/contact.dart';
import 'package:firestore_db/view/register.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final formkey = GlobalKey<FormState>();

  final authCr = AuthController();

  ///Fungsi untuk menampilkan form login dan login
  @override
  Widget build(BuildContext context) {
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

                /// Tombol untuk melakukan login
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      /// Melakukan login dengan email dan kata sandi
                      UserModel? registeredUser = await authCr
                          .signInWithEmailAndPassword(email!, password!);

                      if (registeredUser != null) {
                        /// Tampilan pesan sukses jika login berhasil
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Successful'),
                              content: const Text(
                                  'You have been successfully logged in.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    /// Navigasi ke halaman kontak setelah login sukses
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Contact();
                                    }));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        /// Tampilan pesan gagal jika login gagal
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Failed'),
                              content:
                                  const Text('An error occurred during login.'),
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
                  child: const Text('Login'),
                ),

                /// Tombol untuk menuju halaman pendaftaran
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
