import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/GPAData.dart';
import 'package:grades/features/authentication/screens/login/login.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:studentvueclient/studentvueclient.dart';

import '../../../../common/data/ClassData.dart';
import '../../../../common/data/FlChardData.dart';
import '../../../../common/data/GPAHistory.dart';
import '../../../../common/data/History.dart';
import '../../../../common/data/Period.dart';
import '../../../../common/data/User.dart';

class GenesisUserController extends GetxController {
  //vars

  Map<String, dynamic> userdata = {
    "name": "",
    "stats": {"apcount": 0, "rank": 15, "absences": 4},
    "courses": {},
    "assignments": [],
  };

  var localStorage = GetStorage();

  var users = GetStorage().read("users");
  User? curUser;

  //"history": {"overall": {curDate, "4.43"
  Map<String, String> gpas = <String, String>{"overall": "4.51"};
  Map<String, GPAHistory> history = <String, GPAHistory>{};

  String gpaGoal = "4.40";

  //methods

  void initUser(String username) {
    users = GetStorage().read("users");
    curUser = User.fromMap(users[username]);
  }

  List<Period> getPeriods() {
    return curUser?.periods ?? [];
  }

  int getMissing(ClassData course) {
    int res = 0;
    for (Assignment assignment in course.assignments) {
      if (assignment.notes.toLowerCase().contains("missing")) {
        res += 1;
      }
    }
    return res;
  }

  List<Assignment> getAllAssignments() {
    return curUser?.assignments ?? [];
  }

  ClassData? findClassWithAssignment(Assignment assignment) {
    for (Period period in curUser?.periods ?? []) {
      ClassData curClass = period.classData.last;
      if (curClass.assignments.contains(assignment)) {
        return curClass;
      }
    }
  }

  //void getWeekTrend(String course) #accesses local storage and does a bnch of math

  //void getMonthTrend(String course)

  //void getSemesterTrend(String course)

  //void getGradebook() => Map<String, Map<String, String>> ex. {"Multi": {"letter": "A", "percent": "92.5"}}

  //void getStats() =>

  String getUsername() {
    return curUser?.name ?? "who are you";
  }

  String getGPAGoal() {
    return gpaGoal;
  }

  String getGPA() {
    History? overallHistory = curUser?.history
        .firstWhere((historyPoint) => historyPoint.name == "overall");
    GPAData? mostRecentGPA = overallHistory?.history.last;
    return mostRecentGPA?.gpa.toStringAsFixed(2) ?? "-1.0";
  }

  String? amntFromGoal() {
    double amount = double.parse(getGPA()) - double.parse(getGPAGoal());
    return amount.toStringAsFixed(2);
  }

  FlChartData createDataPoints(History history) {
    List<FlSpot> spots = [];
    Map<int, String> leftTitle = {};
    Map<int, String> bottomTitle = {};
    double inc = 0.0;
    double minX = 0;
    double minY = 100000;
    double maxX = -1.0;
    double maxY = -1.0;

    // Generate FlSpot data and determine min/max Y values
    for (GPAData dataPoint in history.history) {
      double gpa =
          dataPoint.gpa * 10; // Multiply by 10 for internal calculation
      if (gpa < minY) {
        minY = gpa;
      }
      if (gpa > maxY) {
        maxY = gpa;
      }
      spots.add(FlSpot(inc, gpa));
      inc += 1;
    }
    maxX = inc - 1;

    // Adjust Y limits slightly for visual padding
    minY -= 5;
    maxY += 5;
    if (maxY > 1000) {
      // Since we're now working with values multiplied by 10
      maxY = 1000;
    }

    // Define 4 intervals for the left title (Y-axis)
    double yInterval =
        (maxY - minY) / 3; // 4 labels -> 3 intervals between them
    for (int i = 0; i <= 3; i++) {
      double yValue = minY + (i * yInterval);
      leftTitle[yValue.round()] =
          (yValue / 10).toStringAsFixed(1); // Divide by 10 for display
    }

    // Populate bottom titles (X-axis) with corresponding labels
    for (int i = 0; i <= maxX; i++) {
      bottomTitle[i] = '$i'; // Example: 'Q1', 'Q2', etc. for each data point
    }

    // Return FlChartData with calculated titles and spots
    return FlChartData(
      spots: spots,
      leftTitle: leftTitle,
      bottomTitle: bottomTitle,
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }

  String getClassRank() {
    return userdata["stats"]["rank"].toString();
  }

  int getAbsences() {
    return curUser?.absences ?? 0;
  }

  bool requiresGPAInput() {
    History? overallHistory = curUser?.history
        .firstWhere((historyPoint) => historyPoint.name == "overall");
    return overallHistory?.history.isEmpty ?? true;
  }

  String getAPCount() {
    int inc = 0;
    for (Period period in curUser?.periods ?? []) {
      ClassData curClass = period.classData.last;
      if (curClass.courseName.contains("AP")) {
        inc += 1;
      }
    }
    return inc.toString();
  }
}
