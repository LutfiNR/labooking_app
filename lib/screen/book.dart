import 'package:flutter/material.dart';//-
import 'package:labooking_app/api/api_service.dart';//-
import 'package:labooking_app/screen/home.dart';//-
import 'package:shared_preferences/shared_preferences.dart';//-
import 'login.dart';//-
/// This class represents the booking form screen in the lab booking application.
/// It allows users to input their phone number, activity, start and end times, and lecturer's name.
/// The form is validated and submitted to the server using the [ApiService].
/// If the token is expired, the user is redirected to the login screen.
/// The form also displays a note and a submit button.
class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _lecturerController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;

  @override
  void initState() {
    super.initState();
    _checkTokenExpiration();
  }

  /// Checks if the token is expired.
  /// If the token is expired, it removes the token from local storage and redirects the user to the login screen.
  Future<void> _checkTokenExpiration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenExpiration = prefs.getInt('tokenExpiration');
    if (tokenExpiration != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime > tokenExpiration) {
        // Token is expired, remove it from local storage and redirect to login
        await prefs.remove('token');
        await prefs.remove('tokenExpiration');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  /// Displays a date picker and time picker to select the start or end time of the booking.
  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        setState(() {
          final DateTime selectedDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );

          if (isStartTime) {
            _startDateTime = selectedDateTime;
          } else {
            _endDateTime = selectedDateTime;
          }
        });
      }
    }
  }

  /// Handles the form submission.
  /// Validates the input fields, displays a snackbar with an error message if the input is invalid,
  /// or submits the form to the server using the [ApiService].
  Future<void> _submitForm() async {
    final phone = _phoneController.text;
    final activity = _activityController.text;
    final lecturer = _lecturerController.text;

    // Validates input dates
    if (_startDateTime == null || _endDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end times')),
      );
      return;
    }

    // Uses ApiService to submit form
    try {
      final response = await ApiService().submitBookingForm(
        phone: phone,
        activity: activity,
        start: _startDateTime!,
        end: _endDateTime!,
        lecturer: lecturer,
      );

      // If response is null, user needs to login again
      if (response == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Displays success or failure message based on server response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );

        // If booking is successful, navigate to the home screen
        if (response['success'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } catch (error) {
      // Handles network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  /// Formats the date and time in a specific format.
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Pilih Tanggal dan Waktu';
    }
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Booking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note!: Permintaan penggunaan lab akan di check oleh admin terlebih dahulu. Admin akan mengirimkan pesan konfirmasi melalui WhatsApp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Telepon',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.15),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  hintText: 'Format: 081234567890',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: colorScheme.secondary,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kegiatan',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.15),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _activityController,
                decoration: const InputDecoration(
                  hintText: 'Format: Angkatan - Kelas - Nama Kegiatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
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
              const SizedBox(height: 16),
              const Text(
                'Waktu Mulai',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.15),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _selectDateTime(context, true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.secondary),
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDateTime(_startDateTime),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Waktu Selesai',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.15),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _selectDateTime(context, false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.secondary),
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDateTime(_endDateTime),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Nama Dosen Pengampu',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.15),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _lecturerController,
                decoration: const InputDecoration(
                  hintText: "Drs. xxxxx",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
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
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18, color: colorScheme.tertiary),
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

  @override
  void dispose() {
    _phoneController.dispose();
    _activityController.dispose();
    _lecturerController.dispose();
    super.dispose();
  }
}