import 'package:flutter/material.dart';
import 'app.dart';

/// Ini adalah titik masuk aplikasi.
/// Ia menjalankan widget [MyApp], yang merupakan akar aplikasi.
///
/// Fungsi [main] adalah fungsi pertama yang dieksekusi ketika aplikasi dimulai.
/// Ia mengatur lingkungan yang diperlukan dan menginisialisasi aplikasi.
///
/// Dalam kasus ini, ia memanggil fungsi [runApp] dari paket 'flutter/material.dart',
/// memberikan widget [MyApp] sebagai argumen.
///
/// Widget [MyApp] didefinisikan dalam file 'app.dart' dan bertanggung jawab untuk membangun antarmuka pengguna aplikasi.

void main() {
  runApp(const MyApp());
}