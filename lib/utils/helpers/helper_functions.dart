import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenesisHelpers {
  static double getWidth() {
    return 0.9;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static int currentQuarter() {
    return 1;
  }

  static int getQuarterOfDate(DateTime date) {
    return 1;
  }

  static List<DateTime> generateDateList(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];

    // Add each date from startDate to endDate
    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }
  static DateTime stringToDateTime(String dateString) {
    DateFormat format = DateFormat("M/d/yyyy");
    return format.parse(dateString);
  }
  
}
