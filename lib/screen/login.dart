import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labooking_app/api/api_service.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Menggunakan controller untuk mengambil input username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Membersihkan controller ketika widget dihapus
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk mendapatkan tanggal kedaluwarsa token dari JWT
  DateTime? _getExpirationDateFromToken(String token) {
    try {
      // Token JWT terdiri dari 3 bagian: header, payload, dan signature
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Token tidak valid');
      }

      // Mendekode bagian payload (bagian kedua)
      final payload = parts[1];

      // Mendekode base64 payload
      final normalizedPayload = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedPayload = json.decode(utf8.decode(decodedBytes));

      // Mengambil waktu kedaluwarsa (exp) dari payload dan mengonversinya ke DateTime
      final int exp = decodedPayload['exp'];
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

      return expirationDate;
    } catch (e) {
      // Menangani error ketika proses decoding token gagal
      print('Error decoding token: $e');
      return null;
    }
  }

  // Fungsi yang menangani proses login
  void _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Validasi input username dan password
    if (username.isEmpty || password.isEmpty) {
      // Tampilkan pesan jika input kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password tidak boleh kosong'),
        ),
      );
      return;
    }

    // Memanggil ApiService untuk login
    try {
      String? token = await ApiService().login(username, password);

      if (token != null) {
        // Jika login berhasil, navigasi ke HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        // Tampilkan pesan login berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Berhasil'),
          ),
        );
      } else {
        // Jika login gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username atau Password salah'),
          ),
        );
      }
    } catch (error) {
      // Menangani error seperti masalah jaringan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        // Scroll untuk menghindari overflow pada layar kecil
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 80), // Padding di atas untuk mengatur posisi elemen
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'La',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    TextSpan(
                      text: 'Booking',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Selamat Datang!!',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 64),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 4), // Spasi antara label dan TextField
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: 'NPM',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8), // Spasi antara label dan TextField
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary,
                    obscureText: true, // Untuk menyembunyikan teks password
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48), // Spasi antara form dan tombol login
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity, // Tombol mengambil lebar penuh
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
