import 'package:flutter/material.dart';
import 'package:labooking_app/model/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulesDataSources extends CalendarDataSource {
  // Constructor to initialize the appointments
  SchedulesDataSources(List<Schedule> schedules) {
    appointments = schedules;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index]
        .from; // Return the start time of the appointment
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to; // Return the end time of the appointment
  }

  @override
  String getSubject(int index) {
    return appointments![index]
        .eventName; // Return the subject of the appointment
  }

  @override
  Color getColor(int index) {
    return appointments![index]
        .background; // Return the color of the appointment
  }

  @override
  bool isAllDay(int index) {
    return appointments![index]
        .isAllDay; // Return whether the appointment is an all-day event
  }
}
