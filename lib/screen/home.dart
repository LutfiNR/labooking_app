import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Schedule> _schedules = [];
  // final ApiService apiService = ApiService();

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchSchedules();
  // }

  // Future<void> _fetchSchedules() async {
  //   try {
  //     List<Schedule> schedules = await apiService.fetchSchedules();

  //     setState(() {
  //       _schedules = schedules;
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaBooking'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Jadwal Penggunaan Lab. Komputer PTI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView
                  .month,
              todayHighlightColor:
                  Colors.amber,
              selectionDecoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.3),
                shape: BoxShape.rectangle,
              ),
              cellBorderColor:
                  Colors.grey.shade200,
              // dataSource: SchedulesDataSources(_schedules),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: true,
                agendaStyle: AgendaStyle(
                  backgroundColor: Colors.grey.shade100,
                  appointmentTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                  });
                },
                child: const Text('Today'),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Pendidikan Teknologi Informasi © 2024 - All rights reserved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

