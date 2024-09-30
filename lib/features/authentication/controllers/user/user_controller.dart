import 'package:cloud_firestore/cloud_firestore.dart';
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

  var localStorage = GetStorage();

  var users = GetStorage().read("users");
  User? curUser;

  //"history": {"overall": {curDate, "4.43"
  Map<String, String> gpas = <String, String>{"overall": "4.51"};
  Map<String, GPAHistory> history = <String, GPAHistory>{};

  String gpaGoal = "4.40";

  //methods

  String getGPAYearlyChange() {
    History? overallHistory = curUser?.history
        .firstWhere((historyPoint) => historyPoint.name == "overall");
    double curGPA = overallHistory?.history.last.gpa ?? 0.0;
    double res = double.parse(
        (curGPA - (curUser?.initialCumGPA ?? 0.0)).toStringAsFixed(0));
    if (res == 0) {
      return "+0";
    }
    if (res > 0) {
      return "+$res";
    } else {
      return "-$res";
    }
  }

  double getMonthlyChange(ClassData course) {
    DateTime now = DateTime.now();
    DateTime monthAgoDate = DateTime(now.year, now.month - 1, now.day);

    //TODO: beginning of quarter dynanmic retreival
    DateTime beginningOfQuarter = DateTime(now.year, 8, 19);

    if (monthAgoDate.isBefore(beginningOfQuarter)) {
      monthAgoDate = beginningOfQuarter;
    }

    double grade = GenesisGradeCalculations.calculateGradeOn(
        date: monthAgoDate, course: course);

    return double.parse((course.percent - grade).toStringAsFixed(1));
  }

  double getWeeklyChange(ClassData course) {
    DateTime now = DateTime.now();
    DateTime weekAgoDate = now.subtract(Duration(days: 7));

    // TODO: beginning of quarter dynamic retrieval
    DateTime beginningOfQuarter = DateTime(now.year, 8, 19);

    // Ensure we don't go before the beginning of the quarter
    if (weekAgoDate.isBefore(beginningOfQuarter)) {
      weekAgoDate = beginningOfQuarter;
    }

    // Calculate the grade as of the date one week ago
    double grade = GenesisGradeCalculations.calculateGradeOn(
        date: weekAgoDate, course: course);

    // Return the weekly change rounded to 1 decimal place
    return double.parse((course.percent - grade).toStringAsFixed(1));
  }

  double getQuarterChange(ClassData course) {
    double grade = (course.assignments.last.earnedPoints /
            course.assignments.last.possiblePoints) *
        100;
    return double.parse((course.percent - grade).toStringAsFixed(1));
  }

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
    int multiplier = history.name == "overall" ? 10 : 10;
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
          dataPoint.gpa * multiplier; // Multiply by 10 for internal calculation
      if (gpa < minY) {
        minY = gpa;
      }
      if (gpa > maxY) {
        maxY = gpa;
      }
      spots.add(FlSpot(inc, double.parse(gpa.toStringAsFixed(1))));
      inc += 1;
    }
    maxX = inc - 1;

    // Adjust Y limits slightly for visual padding
    if (!(history.name == "overall")) {
      minY -= 5;
      maxY += 5;
    } else {
      minY -= 0.3;
      maxY += 0.3;
    }
    if (maxY > (100 * multiplier)) {
      // Since we're now working with values multiplied by 10
      maxY = 100.0 * multiplier;
    }

    // Define 4 intervals for the left title (Y-axis)
    double yInterval =
        (maxY - minY) / 3; // 4 labels -> 3 intervals between them
    for (int i = 0; i <= 3; i++) {
      double yValue = minY + (i * yInterval);
      leftTitle[yValue.round()] =
          (yValue / multiplier).toStringAsFixed(1); // Divide by 10 for display
    }

    // Populate bottom titles (X-axis) with corresponding labels
    for (int i = 0; i <= maxX; i++) {
      bottomTitle[i] = '$i'; // Example: 'Q1', 'Q2', etc. for each data point
    }
    bottomTitle = {};

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

  Map<String, int> getClassRank() {
    return curUser?.rank ?? {};
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

  Future<void> addOrReplaceDocument(String id, double gpa) async {
    // Reference to the Firestore collection "class_ranking"
    CollectionReference classRanking =
        FirebaseFirestore.instance.collection('class_ranking');

    try {
      // Using set with merge: false will replace the document completely
      await classRanking.doc(id).set({
        'id': id,
        'gpa': gpa,
      }, SetOptions(merge: false));
    } catch (e) {
      print("Error adding/replacing document: $e");
    }
  }

  Future<Map<String, int>> getGpaRanking(double gpa) async {
    CollectionReference classRanking =
        FirebaseFirestore.instance.collection('class_ranking');

    try {
      // Fetch all documents from the collection
      QuerySnapshot snapshot = await classRanking.get();

      // Extract all GPAs and sort them in descending order
      List<double> allGpas = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['gpa'] as double)
          .toList();

      // Sort GPAs in descending order
      allGpas.sort((a, b) => b.compareTo(a));

      // Find the rank of the provided GPA (rank is 1-based)
      int rank = allGpas.indexOf(gpa) + 1;

      // Total number of documents (students) in the collection
      int total = allGpas.length;

      // Return the rank and the total number of students
      return {
        'rank': rank,
        'total': total,
      };
    } catch (e) {
      print("Error getting ranking: $e");
      return {
        'rank': -1, // Return an invalid rank in case of an error
        'total': 0
      };
    }
  }
}
