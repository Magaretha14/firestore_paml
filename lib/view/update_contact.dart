import 'package:flutter/material.dart';
import 'package:firestore_db/controller/contact_controller.dart';
import 'package:firestore_db/model/contact_model.dart';
import 'package:firestore_db/view/contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    Key? key,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();

  final formkey = GlobalKey<FormState>();

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  ///Fungsi tampilan untuk update kontak
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              /// Input untuk mengedit nama
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onSaved: (value) {
                  newname = value;
                },
                initialValue: widget.name,
              ),

              /// Input untuk mengedit nomor telepon
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onSaved: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
              ),

              /// Input untuk mengedit alamat email
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onSaved: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
              ),

              /// Input untuk mengedit alamat
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onSaved: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
              ),

              /// Tombol untuk menyimpan perubahan kontak
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel cm = ContactModel(
                        id: widget.id,
                        name: newname!.toString(),
                        phone: newphone!.toString(),
                        email: newemail!.toString(),
                        address: newaddress!.toString());
                    contactController.updateContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));

                    /// Navigasi kembali ke halaman daftar kontak setelah mengedit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                },
                child: const Text('Edit Contact'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
