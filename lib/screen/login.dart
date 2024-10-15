import 'package:flutter/material.dart'; // Mengimpor paket Material Design
// import 'home.dart'; // Mengimpor layar Home (dikomentari untuk saat ini)

/// Kelas yang merepresentasikan layar login aplikasi
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Konstruktor kelas

  @override
  _LoginScreenState createState() => _LoginScreenState(); // Membuat state untuk layar login
}

/// State untuk layar login
class _LoginScreenState extends State<LoginScreen> {
  // Kontroler untuk mengambil input dari pengguna
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Menghapus kontroler saat layar tidak lagi digunakan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk menangani proses login (dikomentari untuk saat ini)
  // void _handleLogin() {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;

  //   if (username.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Username atau Password tidak boleh kosong'),
  //       ),
  //     );
  //   } else {
  //     if (username == 'admin' && password == '1234') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Username atau Password salah'),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme; // Mendapatkan skema warna dari tema

    return Scaffold(
      backgroundColor: colorScheme.primary, // Mengatur warna latar belakang
      body: SingleChildScrollView(
        // Menggunakan SingleChildScrollView untuk mencegah overflow pada layar kecil
        padding: const EdgeInsets.all(48.0), // Padding untuk konten
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 80), // Ruang di atas untuk pemusatan yang lebih baik
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'La', // Teks "La"
                      style: TextStyle(
                        fontSize: 24, // Ukuran font untuk "La"
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary, // Warna teks berdasarkan skema warna
                      ),
                    ),
                    TextSpan(
                      text: 'Booking', // Teks "Booking"
                      style: TextStyle(
                        fontSize: 24, // Ukuran font untuk "Booking"
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary, // Warna teks berdasarkan skema warna
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Ruang antara judul dan teks sambutan
              const Text(
                'Selamat Datang!!', // Teks sambutan
                style: TextStyle(
                    fontSize: 64, // Ukuran font
                    fontWeight: FontWeight.w900,
                    height: 1.15),
              ),
              const SizedBox(height: 64), // Ruang antara teks sambutan dan kolom input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Username', // Label untuk input username
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.15),
                  ),
                  const SizedBox(height: 4), // Ruang antara label dan TextField
                  TextField(
                    controller: _usernameController, // Menghubungkan TextField dengan kontroler
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // Border untuk TextField
                      hintText: 'NPM', // Placeholder
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey, // Warna border saat fokus
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary, // Warna kursor
                    style: const TextStyle(
                      fontSize: 16, // Ukuran teks dalam TextField
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 14), // Ruang antara username dan password
                  const Text(
                    'Password', // Label untuk input password
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.15),
                  ),
                  const SizedBox(height: 8), // Ruang antara label dan TextField
                  TextField(
                    controller: _passwordController, // Menghubungkan TextField dengan kontroler
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // Border untuk TextField
                      hintText: 'Password', // Placeholder
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey, // Warna border saat fokus
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary, // Warna kursor
                    obscureText: true, // Menyembunyikan input password
                    style: const TextStyle(
                      fontSize: 16, // Ukuran teks dalam TextField
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48), // Ruang antara field dan tombol
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity, // Membuat tombol mengambil lebar penuh
                      child: ElevatedButton(
                        onPressed: () {
                          // Aksi saat tombol Login ditekan
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary, // Warna latar belakang tombol
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding tombol
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Mengatur radius border menjadi 0
                          ),
                        ),
                        child: Text(
                          'Login', // Teks pada tombol Login
                          style: TextStyle(fontSize: 18, color: colorScheme.tertiary), // Ukuran dan warna teks tombol
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // Ruang antara tombol Login dan Sign Up
                    SizedBox(
                      width: double.infinity, // Membuat tombol mengambil lebar penuh
                      child: OutlinedButton(
                        onPressed: () {
                          // Aksi saat tombol Sign Up ditekan
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black), // Warna border
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding tombol
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Mengatur radius border menjadi 0
                          ),
                        ),
                        child: const Text(
                          'Sign Up', // Teks pada tombol Sign Up
                          style: TextStyle(fontSize: 18, color: Colors.black), // Ukuran dan warna teks tombol
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
