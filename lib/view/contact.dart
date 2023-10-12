import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db/controller/contact_controller.dart';
import 'package:firestore_db/view/add_contact.dart';
import 'package:firestore_db/view/update_contact.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

///Fungsi untuk menampilkan data kontak
class _ContactState extends State<Contact> {
  var cc = ContactController();

  @override
  void initState() {
    /// Memuat daftar kontak saat halaman dimuat
    cc.getContact();
    super.initState();
  }

  ///Fungsi untuk menampilkan data kontak
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Contact List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: cc.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    /// Menampilkan indikator loading saat data belum tersedia
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List<DocumentSnapshot> data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onLongPress: () {
                            /// Navigasi ke halaman pembaruan kontak dengan mengirimkan data kontak yang ada
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateContact(
                                    id: data[index]['id'],
                                    name: data[index]['name'],
                                    phone: data[index]['phone'],
                                    email: data[index]['email'],
                                    address: data[index]['address']),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purpleAccent,
                                child: Text(
                                  data[index]['name']
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(data[index]['name']),
                              subtitle: Text(data[index]['phone']),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  /// Menghapus kontak dengan mengirim ID kontak yang akan dihapus
                                  cc.removeContact(
                                      data[index]['id'].toString());

                                  /// Memuat kembali daftar kontak setelah penghapusan
                                  setState(() {
                                    cc.getContact();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Contact Deleted')));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// Navigasi ke halaman tambah kontak
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddContact(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
