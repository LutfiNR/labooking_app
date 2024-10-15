import 'package:flutter/material.dart';

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

  void _submitForm() {
    // Logic to handle form submission
    final phone = _phoneController.text;
    final activity = _activityController.text;
    final lecturer = _lecturerController.text;

    print('Phone: $phone');
    print('Activity: $activity');
    print('Start DateTime: $_startDateTime');
    print('End DateTime: $_endDateTime');
    print('Lecturer: $lecturer');

    // Reset form (optional)
    _phoneController.clear();
    _activityController.clear();
    _lecturerController.clear();
    setState(() {
      _startDateTime = null;
      _endDateTime = null;
    });
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Pilih Tanggal dan Waktu';
    }
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Booking Lab. Komputer PTI',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Telepon',
                  hintText: 'Format: 081234567890',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _activityController,
                decoration: const InputDecoration(
                  labelText: 'Kegiatan',
                  hintText: 'Format: Angkatan - Kelas - Nama Mata Kuliah/Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Waktu Mulai'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDateTime(context, true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDateTime(_startDateTime),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Waktu Selesai'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDateTime(context, false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDateTime(_endDateTime),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _lecturerController,
                decoration: const InputDecoration(
                  labelText: 'Nama Dosen Pengampu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigate back action
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.black),
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