import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labooking_app/model/schedule_model.dart';

class ApiService {
  // Fetch meetings from API
  Future<List<Schedule>> fetchSchedules() async {
    final response = await http.get(Uri.parse(
        'https://api-labooking.vercel.app/schedules')); // Replace with your API URL

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      // Convert the JSON data to a list of Meeting objects
      return data.map((schedule) {
        DateTime startTime = DateTime.parse(schedule['start']);
        DateTime endTime = DateTime.parse(schedule['end']);
        return Schedule(
            schedule['title'], startTime, endTime, Colors.amber, false);
      }).toList();
    } else {
      throw Exception('Failed to load meetings');
    }
  }
}
