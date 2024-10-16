import 'package:flutter/material.dart';
import 'package:labooking_app/model/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulesDataSources extends CalendarDataSource {
  // Constructor untuk menginisialisasi daftar jadwal/appointments
  SchedulesDataSources(List<Schedule> schedules) {
    appointments = schedules; // Set daftar appointments dari data Schedule
  }

  // Mengambil waktu mulai appointment berdasarkan indeks
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from; // Mengembalikan waktu mulai dari appointment
  }

  // Mengambil waktu selesai appointment berdasarkan indeks
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to; // Mengembalikan waktu selesai dari appointment
  }

  // Mengambil nama atau subjek appointment berdasarkan indeks
  @override
  String getSubject(int index) {
    return appointments![index].eventName; // Mengembalikan nama acara dari appointment
  }

  // Mengambil warna latar belakang appointment berdasarkan indeks
  @override
  Color getColor(int index) {
    return appointments![index].background; // Mengembalikan warna background dari appointment
  }

  // Memeriksa apakah appointment adalah acara sepanjang hari (all-day event)
  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay; // Mengembalikan apakah event berlangsung sepanjang hari
  }
}

