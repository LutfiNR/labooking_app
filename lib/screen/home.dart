import 'package:flutter/material.dart'; // Flutter UI library
import 'package:labooking_app/api/api_service.dart'; // Importing API service
import 'package:labooking_app/model/schedule_model.dart'; // Schedule model
import 'package:labooking_app/model/schedules_data_source.dart'; // Calendar data source
import 'package:labooking_app/screen/book.dart'; // Booking form screen
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences for token handling
import 'package:syncfusion_flutter_calendar/calendar.dart'; // Syncfusion calendar for scheduling
import 'login.dart'; // Login screen

// HomeScreen Widget: Stateful because it manages schedules and user authentication status
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// State of HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  // List to hold fetched schedules
  List<Schedule> _schedules = [];
  
  // API service to handle data fetching
  final ApiService apiService = ApiService();

  // CalendarController to manage Syncfusion calendar interactions
  final CalendarController _calendarController = CalendarController();

  // Boolean to track if a user token exists (logged in or not)
  bool _hasToken = false;

  // Initial setup, fetch schedules and check token
  @override
  void initState() {
    super.initState();
    _fetchSchedules(); // Fetch initial data
    _checkToken(); // Check login status
  }

  // Function to check if the token exists in SharedPreferences
  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasToken = prefs.getString('token') != null; // Check if token is stored
    });
  }

  // Function to fetch schedules from the API
  Future<void> _fetchSchedules() async {
    try {
      List<Schedule> schedules = await apiService.fetchSchedules(); // Fetch schedules from API
      setState(() {
        _schedules = schedules; // Update UI with new data
      });
    } catch (e) {
      print('Error: $e'); // Error handling
    }
  }

  // Function to handle user logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token from SharedPreferences
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigate to login screen
    );
  }

  // Function to refresh schedules (e.g., when pulled down to refresh)
  Future<void> _refreshSchedules() async {
    await _fetchSchedules(); // Re-fetch schedules
  }

  // Main UI build function
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme; // Get current color scheme for theming

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary, // Set background color of AppBar
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'La', // First part of the app title
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary, // Use secondary color for "La"
                ),
              ),
              TextSpan(
                text: 'Booking', // Second part of the app title
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.tertiary, // Use tertiary color for "Booking"
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false, // Remove back button by default
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, size: 32), // Button to add a new booking
            onPressed: () {
              if (_hasToken) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingFormScreen(),
                  ),
                ).then((_) => _fetchSchedules()); // Fetch schedules again after returning
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Silahkan Login Terlebih Dahulu')), // Show message if not logged in
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), // Navigate to login if not authenticated
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(_hasToken ? Icons.logout_rounded : Icons.login_rounded, size: 32), // Show logout or login button
            onPressed: () {
              if (_hasToken) {
                _logout(); // Log out if authenticated
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), // Navigate to login screen if not authenticated
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshSchedules, // Pull-to-refresh schedules
        child: ListView(
          padding: const EdgeInsets.all(6.0),
          children: [
            const SizedBox(height: 20), // Spacing
            const Text(
              'Jadwal Penggunaan Lab. Komputer PTI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Title text styling
              textAlign: TextAlign.center,
            ),
            const Divider(color: Colors.grey, thickness: 1), // Horizontal divider
            SizedBox(
              height: 720, // Fixed height to make the calendar scrollable
              child: SfCalendar(
                view: CalendarView.month, // Show month view by default
                controller: _calendarController, // Use the initialized CalendarController
                headerHeight: 64, // Custom height for calendar header
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center, // Center align header text
                  backgroundColor: Colors.white, // White background for the header
                ),
                todayHighlightColor: colorScheme.tertiary, // Highlight today's date
                selectionDecoration: BoxDecoration(
                  color: colorScheme.tertiary.withOpacity(0.2), // Lightly shade selected day
                  shape: BoxShape.rectangle, // Rectangle shape for selection
                ),
                cellBorderColor: Colors.grey.shade300, // Color for the cell borders
                dataSource: SchedulesDataSources(_schedules), // Data source for the calendar
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator, // Display appointments as indicators
                  showAgenda: true, // Show agenda below the calendar
                  agendaStyle: AgendaStyle(
                    backgroundColor: Colors.white, // White background for agenda
                    appointmentTextStyle: TextStyle(
                      color: Colors.black, // Black text for appointments
                      fontSize: 14,
                      fontWeight: FontWeight.w300, // Light text weight
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Add padding to the bottom bar
          child: Text(
            'Pendidikan Teknologi Informasi © 2024 - All rights reserved', // Copyright text
            textAlign: TextAlign.center,
            style: TextStyle(color: colorScheme.secondary, fontSize: 12), // Footer text styling
          ),
        ),
      ),
    );
  }
}
