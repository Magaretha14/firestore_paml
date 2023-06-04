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

  //final List<DocumentSnapshot> data = snapshot.data!;

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  newname = value;
                },
                initialValue: widget.name,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel cm = ContactModel(
                        name: newname!.toString(),
                        phone: newphone!.toString(),
                        email: newemail!.toString(),
                        address: newaddress!.toString());
                    contactController.updateContact(cm, widget.id.toString(),
                        newname!, newphone!, newemail!, newaddress!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                  //print(cm);
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
