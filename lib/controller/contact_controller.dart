import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }
}
