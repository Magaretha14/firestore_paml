import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_db/view/contact.dart';
import 'package:flutter/material.dart';

/// Fungsi utama yang akan dijalankan saat aplikasi dimulai
Future main() async {
  /// Memastikan bahwa Flutter sudah siap untuk dijalankan
  WidgetsFlutterBinding.ensureInitialized();

  /// Menginisialisasi Firebase untuk digunakan dalam aplikasi
  await Firebase.initializeApp();

  /// Menjalankan aplikasi Flutter
  runApp(const MyApp());
}

/// Kelas utama yang mewakili aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Konfigurasi tampilan aplikasi
      debugShowCheckedModeBanner: false,

      /// Menghilangkan label "Debug" di sudut kanan atas
      title: 'My Pregnant & Tbc',

      /// Judul aplikasi

      /// Tema aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        /// Konfigurasi warna tema
        useMaterial3: true,

        /// Mengaktifkan Material 3 (jika tersedia)
      ),

      /// Halaman awal aplikasi
      home: Contact(),

      /// Menampilkan halaman daftar kontak sebagai halaman awal
    );
  }
}
