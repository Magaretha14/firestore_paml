import 'package:firestore_db/controller/contact_controller.dart';
import 'package:firestore_db/model/contact_model.dart';
import 'package:firestore_db/view/contact.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

///Fungsi untuk menambahkan kontak
class _AddContactState extends State<AddContact> {
  var contactController = ContactController();

  final formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? email;
  String? address;

  ///Fungsi untuk menambahkan kontak dengan menampilkan form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              /// Input untuk nama kontak
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),

              /// Input untuk nomor telepon kontak
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  phone = value;
                },
              ),

              /// Input untuk alamat email kontak
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),

              /// Input untuk alamat kontak
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
              ),

              /// Tombol untuk menambahkan kontak baru
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    /// Membuat objek ContactModel dari input pengguna
                    ContactModel cm = ContactModel(
                        name: name!,
                        phone: phone!,
                        email: email!,
                        address: address!);

                    /// Menambahkan kontak ke database menggunakan ContactController
                    contactController.addContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Added')));

                    /// Kembali ke halaman daftar kontak (Contact)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                },
                child: const Text('Add Contact'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
