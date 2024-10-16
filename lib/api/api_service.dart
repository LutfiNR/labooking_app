import 'dart:convert'; // Import untuk menangani encoding/decoding JSON
import 'package:flutter/material.dart'; // Import untuk menggunakan komponen UI Material Design
import 'package:http/http.dart' as http; // Import untuk membuat permintaan HTTP
import 'package:labooking_app/model/schedule_model.dart'; // Import model Schedule
import 'package:shared_preferences/shared_preferences.dart'; // Import untuk menyimpan dan mengambil data dari SharedPreferences

class ApiService {
  // Fungsi untuk mengambil data jadwal dari API
  Future<List<Schedule>> fetchSchedules() async {
    // Membuat permintaan HTTP GET untuk mengambil data jadwal dari API
    final response = await http.get(Uri.parse(
        'https://api-labooking.vercel.app/schedules')); // URL endpoint API untuk mengambil jadwal

    // Memeriksa apakah respons dari server berhasil (kode status 200)
    if (response.statusCode == 200) {
      // Mengurai (decode) respons JSON menjadi List objek dinamis
      List<dynamic> data = jsonDecode(response.body);

      // Memetakan data JSON menjadi daftar objek Schedule
      return data.map((schedule) {
        // Mengurai (parse) string waktu mulai dan selesai menjadi objek DateTime
        DateTime startTime = DateTime.parse(schedule['start']);
        DateTime endTime = DateTime.parse(schedule['end']);
        
        // Mengembalikan objek Schedule baru untuk setiap item dalam daftar
        return Schedule(
            schedule['title'], // Judul jadwal
            startTime,         // Waktu mulai jadwal
            endTime,           // Waktu selesai jadwal
          Color.fromRGBO(244, 177, 20, 1), // Warna default untuk jadwal
            false);           // Nilai default apakah acara berlangsung sepanjang hari
      }).toList(); // Mengonversi data yang sudah dipetakan menjadi List objek Schedule
    } else {
      // Jika kode respons bukan 200, lemparkan exception dengan pesan error
      throw Exception('Gagal memuat jadwal');
    }
  }

  // Fungsi untuk login ke API
  Future<String?> login(String username, String password) async {
    // URL API untuk login
    final url = Uri.parse('https://api-labooking.vercel.app/login');

    // Membuat permintaan POST ke API dengan data login (username dan password)
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Set header sebagai JSON
      body: jsonEncode({'username': username, 'password': password}), // Encode data login ke JSON
    );

    // Jika status response adalah 200, berarti login berhasil
    if (response.statusCode == 200) {
      // Mengurai body response JSON untuk mendapatkan token
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String token = responseData['token'];

      // Mendapatkan tanggal kedaluwarsa token dari fungsi bantu
      DateTime? expirationDate = _getExpirationDateFromToken(token);
      if (expirationDate != null) {
        // Simpan token dan tanggal kedaluwarsa ke SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('token_expiration', expirationDate.toIso8601String());
      }

      // Mengembalikan token jika login berhasil
      return token;
    } else {
      // Mengembalikan null jika login gagal (misalnya karena username/password salah)
      return null;
    }
  }

  // Fungsi bantu untuk mendapatkan tanggal kedaluwarsa token (ini contoh saja)
  DateTime? _getExpirationDateFromToken(String token) {
    // Logika untuk menghitung atau mengurai expiration date dari token (misalnya, JWT)
    // Contoh: di sini token dianggap berlaku 1 jam setelah login
    return DateTime.now().add(const Duration(hours: 1));
  }

  // Fungsi untuk submit form booking
  Future<Map<String, dynamic>?> submitBookingForm({
    required String phone,
    required String activity,
    required DateTime start,
    required DateTime end,
    required String lecturer,
  }) async {
    // Mendapatkan token dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('token');

    // Jika token tidak ada, return null
    if (authToken == null) {
      return null;
    }

    // Data yang akan dikirim ke server dalam bentuk JSON
    final data = {
      'phone': phone, // Nomor telepon pengguna
      'activity': activity, // Aktivitas yang akan dilakukan
      'start': start.toIso8601String(), // Waktu mulai aktivitas dalam format ISO8601
      'end': end.toIso8601String(), // Waktu selesai aktivitas dalam format ISO8601
      'dosen': lecturer, // Nama dosen pembimbing
    };

    // Mengirim permintaan POST ke API
    try {
      final response = await http.post(
        Uri.parse('https://api-labooking.vercel.app/booking'),
        headers: {
          'Content-Type': 'application/json', // Set header sebagai JSON
          'Authorization': 'Bearer $authToken', // Sertakan token otentikasi di header
        },
        body: json.encode(data), // Encode data ke dalam format JSON
      );

      // Memeriksa jika permintaan berhasil
      if (response.statusCode == 200) {
        return json.decode(response.body); // Mengembalikan data dari respons
      } else {
        // Mengembalikan pesan error dari server jika status code bukan 200
        return json.decode(response.body);
      }
    } catch (error) {
      // Jika terjadi error, lemparkan exception dengan pesan error
      throw Exception('Error submitting form: $error');
    }
  }
}
