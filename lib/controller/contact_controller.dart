import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db/model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  /// StreamController untuk mengelola aliran (stream) data dari Firestore
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  /// Fungsi ini digunakan untuk menambahkan kontak ke Firestore.
  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    /// Menambahkan dokumen baru ke koleksi 'contacts' dan mendapatkan referensinya
    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    /// Memperbarui dokumen dengan data ContactModel yang lebih lengkap
    await docRef.update(contactModel.toMap());
  }

  /// Fungsi ini digunakan untuk memperbarui kontak dalam Firestore.
  Future<void> updateContact(ContactModel ctmodel) async {
    final ContactModel contactModel = ContactModel(
        id: ctmodel.id,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    /// Memperbarui dokumen dengan data ContactModel yang diberikan
    await contactCollection.doc(ctmodel.id).update(contactModel.toMap());
  }

  /// Fungsi ini digunakan untuk menghapus kontak dari Firestore berdasarkan ID.
  Future<void> removeContact(String id) async {
    await contactCollection.doc(id).delete();
    await getContact();
  }

  /// Fungsi ini digunakan untuk mendapatkan daftar kontak dari Firestore.
  Future getContact() async {
    /// Mendapatkan seluruh dokumen dalam koleksi 'contacts'
    final contact = await contactCollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }
}
