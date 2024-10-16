import 'package:flutter/material.dart';

class Schedule {
  // Konstruktor untuk kelas Schedule
  Schedule(this.eventName, this.from, this.to, this.background, this.isAllDay);

  // Properti dari kelas Schedule
  String eventName;    // Nama acara/jadwal
  DateTime from;       // Waktu mulai acara
  DateTime to;         // Waktu selesai acara
  Color background;    // Warna latar belakang untuk acara/jadwal (misalnya untuk ditampilkan di UI)
  bool isAllDay;       // Penanda apakah acara berlangsung sepanjang hari atau tidak
}
