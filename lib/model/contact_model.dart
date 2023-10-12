import 'dart:convert';

class ContactModel {
  String? id;
  final String name;
  final String phone;
  final String email;
  final String address;

  /// Konstruktor untuk membuat objek ContactModel
  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  /// Mengonversi objek ContactModel menjadi Map (untuk penyimpanan di Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  /// Membuat objek ContactModel dari Map (saat mendapatkan data dari Firestore)
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
    );
  }

  /// Mengonversi objek ContactModel menjadi JSON string
  String toJson() => json.encode(toMap());

  /// Membuat objek ContactModel dari JSON string (misalnya, saat menerima data dari API)
  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));
}
