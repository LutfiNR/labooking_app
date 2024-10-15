import 'package:flutter/material.dart'; // Mengimpor paket Material Design
import 'package:labooking_app/screen/home.dart';
import 'package:labooking_app/screen/login.dart'; // Mengimpor layar login dari aplikasi LaBooking

// Kelas utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor dengan super key

  @override
  Widget build(BuildContext context) {
    // Metode untuk membangun widget antarmuka pengguna
    return MaterialApp(
      title: 'LaBooking', // Judul aplikasi yang ditampilkan di taskbar
      theme: ThemeData(
        // Mengatur tema aplikasi
        colorScheme: const ColorScheme.light(
            // Mengatur skema warna
            primary: Color.fromRGBO(230, 232, 230, 1), // Warna utama aplikasi
            secondary: Color.fromRGBO(8, 7, 8, 1), // Warna sekunder aplikasi
            tertiary: Color.fromRGBO(244, 206, 20, 1) // Warna tersier aplikasi
        ),
        useMaterial3: true, // Mengaktifkan penggunaan Material Design versi 3
      ),
      home: const HomeScreen(), // Menentukan layar awal aplikasi
    );
  }
}
