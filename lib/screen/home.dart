import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'login.dart';

// HomeScreen merupakan StatefulWidget yang menjadi tampilan utama aplikasi setelah login.
// Ini digunakan untuk menampilkan jadwal penggunaan Lab. Komputer PTI.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel berikut telah dikomentari karena tidak digunakan dalam contoh ini.
  // Mereka seharusnya digunakan untuk mengambil data jadwal dari API:
  // List<Schedule> _schedules = [];
  // final ApiService apiService = ApiService();

  // Metode initState dipanggil ketika widget pertama kali dibangun.
  // Biasanya digunakan untuk inisialisasi atau memuat data.
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchSchedules(); // Metode untuk mengambil jadwal
  // }

  // Metode untuk mengambil jadwal dari API
  // Future<void> _fetchSchedules() async {
  //   try {
  //     List<Schedule> schedules = await apiService.fetchSchedules();
  //     setState(() {
  //       _schedules = schedules; // Memperbarui jadwal yang diambil dari API
  //     });
  //   } catch (e) {
  //     print('Error: $e'); // Menampilkan error jika terjadi kegagalan
  //   }
  // }

  // Widget build mendefinisikan UI halaman home screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaBooking'), // Judul aplikasi
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali pada app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline), // Tombol tambah (belum diberi fungsi)
            onPressed: () {
              // Fungsi akan ditambahkan kemudian
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle), // Tombol untuk menuju halaman login
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigasi ke halaman login
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Judul di bawah app bar yang menunjukkan konteks jadwal
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Jadwal Penggunaan Lab. Komputer PTI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Expanded widget digunakan untuk memperluas kalender agar mengisi ruang yang tersedia
          Expanded(
            child: SfCalendar(
              view: CalendarView.month, // Menampilkan kalender dalam tampilan bulanan
              todayHighlightColor: Colors.amber, // Warna yang menyoroti hari ini
              selectionDecoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.3), // Warna saat tanggal dipilih
                shape: BoxShape.rectangle, // Bentuk sorotan tanggal
              ),
              cellBorderColor: Colors.grey.shade200, // Warna garis pembatas antar sel kalender
              // Data untuk jadwal seharusnya disediakan oleh SchedulesDataSources
              // dataSource: SchedulesDataSources(_schedules),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment, // Menampilkan jadwal langsung di dalam kalender
                showAgenda: true, // Menampilkan agenda di bawah kalender
                agendaStyle: AgendaStyle(
                  backgroundColor: Colors.grey.shade100, // Warna latar belakang agenda
                  appointmentTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ), // Gaya teks untuk jadwal di agenda
                ),
              ),
            ),
          ),
          // Baris di bagian bawah yang menampilkan tombol navigasi kalender
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back), // Tombol untuk kembali ke bulan sebelumnya
                onPressed: () {
                  // Fungsi akan ditambahkan nanti
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Setel ulang kalender ke tanggal hari ini
                  });
                },
                child: const Text('Today'), // Tombol untuk kembali ke tanggal hari ini
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward), // Tombol untuk maju ke bulan berikutnya
                onPressed: () {
                  // Fungsi akan ditambahkan nanti
                },
              ),
            ],
          ),
        ],
      ),
      // Bagian bawah aplikasi menampilkan hak cipta
      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Pendidikan Teknologi Informasi © 2024 - All rights reserved', // Informasi hak cipta
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
