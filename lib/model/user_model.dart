import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String Uid;

  UserModel({
    required this.name,
    required this.email,
    required this.Uid,
  });

  /// Mengonversi objek UserModel menjadi Map (mungkin digunakan untuk penyimpanan di Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'Uid': Uid,
    };
  }

  /// Membuat objek UserModel dari Map (saat mendapatkan data dari Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      Uid: map['Uid'] ?? '',
    );
  }

  /// Mengonversi objek UserModel menjadi JSON string
  String toJson() => json.encode(toMap());

  /// Membuat objek UserModel dari JSON string (misalnya, saat menerima data dari API)
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  /// Membuat salinan objek UserModel dengan kemungkinan pembaruan pada properti tertentu
  UserModel copyWith({
    String? name,
    String? email,
    String? Uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      Uid: Uid ?? this.Uid,
    );
  }

  @override
  String toString() => 'UserModel(name: $name, email: $email, Uid: $Uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.Uid == Uid;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ Uid.hashCode;

  /// Factory method untuk membuat UserModel dari objek User Firebase Authentication
  static UserModel? fromFirebaseUser(User user) {
    /// Implementasi dari konversi User Firebase Authentication ke UserModel
  }
}
