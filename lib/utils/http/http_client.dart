import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/ClassData.dart';
import 'package:grades/common/data/Period.dart';
import 'package:grades/common/data/User.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../common/data/GPAData.dart';
import '../../common/data/GPAHistory.dart';
import '../../common/data/History.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GenesisHttpClient {
  GenesisUserController user = Get.find<GenesisUserController>();
  List<dynamic> unorderedAssignments = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser() {
    return firestore
        .collection('class_rankings')
        .add({
          'id': '1620426',
          'gpa': 4.43,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static void handleGrade(double grade) {
    var gr = grade * 100;
  }

  Future<void> queryStudentVue(String email, String password) async {
    bool newAssignmentsReturned = false;
    List<String> classesWithUpdatedAssignments = [];
    var localStorage = GetStorage();
    int currentQuarter = 1;
    bool isFirstTime = false;

    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentGradeData currentGb =
        await client.loadGradebook(callback: handleGrade);
    int absences = await client.getAbsences(callback: handleGrade);

    //if user doesn't exist for current user id, create a new user
    localStorage.writeIfNull("users", {});
    Map<dynamic, dynamic> users = localStorage.read("users");
    if (!users.containsKey(email)) {
      isFirstTime = true;
      users[email] = (await makeUser(email, password, currentGb)).toMap();
      localStorage.write("users", users);
    }

    print("hi");

    User curUser = User.fromMap(localStorage.read("users")[email]);

    //update absences

    if (absences != curUser.absences) {
      curUser.absences = absences;
    }

    //TODO: check if any gbTypes are UK, and if so try again

    // update allAssignments, assignments, and percents of each class
    for (Period period in curUser.periods) {
      ClassData curClass = period.classData.last;

      SchoolClass foundClass = currentGb.classes.firstWhere(
          (schoolClass) => schoolClass.className == curClass.courseName);

      //update assignments and allAssignments
      for (Assignment assignment in foundClass.assignments) {
        if ((assignment.possiblePoints >= 0 && assignment.earnedPoints >= 0) &&
            !curClass.assignments.contains(assignment)) {
          curClass.assignments.add(assignment);
          curUser.assignments.add(assignment);
          newAssignmentsReturned = true;
          classesWithUpdatedAssignments.add(curClass.courseName);
        }
      }

      curClass.percent = double.parse(foundClass.pctGrade!);

      orderAssignments(curUser.assignments);
    }

    //calculate cumulative GPA, add it to history
    if (newAssignmentsReturned) {
      History overallHistory =
          curUser.history.firstWhere((history) => history.name == "overall");
      overallHistory.history
          .add(GPAData(calculateCumulativeGPA(curUser, currentQuarter)));
      user.addOrReplaceDocument(email, overallHistory.history.last.gpa);
      Map<String, int> ranking =
      await user.getGpaRanking(overallHistory.history.last.gpa);
      curUser.rank = ranking;
    }

    // update history of user
    for (Period period in curUser.periods) {
      ClassData curClass = period.classData[period.classData.length - 1];
      if (classesWithUpdatedAssignments.contains(curClass.courseName)) {
        History classHistory = curUser.history
            .firstWhere((history) => history.name == curClass.courseName);
        classHistory.history.add(GPAData(curClass.percent));
      }
    }

    print("hello");

    users = localStorage.read("users");
    users[email] = curUser.toMap();
    localStorage.write("users", users);
    return;
  }

  double calculateCumulativeGPA(User curUser, int curQuarter) {
    double outdatedGPA = curUser.initialCumGPA ?? 0.0;
    double creditsTaken = curUser.creditsTaken ?? 1.0;
    double gpaVal = outdatedGPA * creditsTaken;
    if (curQuarter == 1 || curQuarter == 2) {
      for (Period period in curUser.periods) {
        ClassData curClass = period.classData[period.classData.length - 1];
        if (curClass.gradebookCode == "UK" ||
            curClass.gradebookCode == "rolling") {
          gpaVal += GenesisGradeCalculations.gpaFromLetter(
                  GenesisGradeCalculations.percentToLetter(curClass.percent),
                  curClass.courseName) *
              0.5;
          creditsTaken += 0.5;
        } else {
          //TODO: store quarterly grades in ClassData somehow
          //temp solution, just use current grade
          gpaVal += GenesisGradeCalculations.gpaFromLetter(
                  GenesisGradeCalculations.percentToLetter(curClass.percent),
                  curClass.courseName) *
              0.5;
          creditsTaken += 0.5;
        }
      }
    }
    return gpaVal / creditsTaken;
  }

  Future<User> makeUser(
      String email, String password, StudentGradeData currentGb) async {
    //TODO: figure out a way to figure out current quarter
    List<Assignment> allAssignments = [];
    StudentGradeData? currentGb;
    bool isFirstSem = false;
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');

    //if user doesn't exist for current user id, create a new user
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));

    print("Fetching gradebooks");
    StudentGradeData quarter1 =
        await client.loadGradebook(reportPeriod: 0, callback: handleGrade);
    StudentGradeData quarter2 =
        await client.loadGradebook(reportPeriod: 1, callback: handleGrade);
    StudentGradeData? quarter3;
    StudentGradeData? quarter4;
    try {
      quarter3 =
          await client.loadGradebook(reportPeriod: 2, callback: handleGrade);
      quarter4 =
          await client.loadGradebook(reportPeriod: 3, callback: handleGrade);
    } catch (e) {
      isFirstSem = true;
    }
    currentGb = await client.loadGradebook(callback: handleGrade);
    print("Fetched gradebooks");

    //TODO: make sure q1 and q2 classes are the same (like in case of dropouts)
    List<Period> periodsToAdd = [];

    //TODO: add the first cumulative GPA to the beginning of history after it is inputted in gpa_input
    List<History> completeHistory = [History(name: "overall", history: [])];

    if (isFirstSem) {
      String durationCode = "UK";
      int inc = 0;
      for (SchoolClass course in quarter1.classes) {
        String gbType = "UK";
        if (course.assignments.isNotEmpty) {
          var firstQ1Assignment = course.assignments[0].assignmentName;
          var q2Assignments = quarter2.classes[inc].assignments;

          if (q2Assignments.isEmpty ||
              q2Assignments[0].assignmentName != firstQ1Assignment) {
            gbType = "standard";
          } else {
            gbType = "rolling";
          }
        }

        List<Assignment> curAssignments = [];
        for (Assignment assignment in currentGb.classes[inc].assignments) {
          if (assignment.possiblePoints >= 0 && assignment.earnedPoints >= 0) {
            curAssignments.add(assignment);
          }
        }

        List<AssignmentCategory> categories =
            constructCategories2(currentGb.classes[inc], curAssignments);

        ClassData newClass = ClassData(
          categories: categories,
          durationCode: durationCode,
          courseName: course.className,
          percent: double.parse(course.pctGrade!),
          gradebookCode: gbType,
          assignments: curAssignments,
        );

        Period newPeriod = Period(periodNum: inc + 1, classData: [newClass]);
        periodsToAdd.add(newPeriod);
        allAssignments.addAll(curAssignments);
        inc += 1;

        History newHistory =
            History(name: course.className, history: generateHistory(newClass));
        completeHistory.add(newHistory);
      }
    }

    User newUser = User(
      history: completeHistory,
      absences: 0,
      rank: {},
      name: studentData.formattedName!.split(" ")[0],
      assignments: allAssignments,
      periods: periodsToAdd,
    );
    return newUser;
  }

  List<GPAData> generateHistory(ClassData course) {
    //goes from most recent to least recent

    List<GPAData> res = [];
    List<AssignmentCategory> categories = course.categories;
    Map<String, dynamic> categoryMap = {};
    for (AssignmentCategory category in categories) {
      categoryMap[category.name ?? "what"] = {
        "earnedPoints": 0.0,
        "possiblePoints": 0.0,
        "weight": category.weight
      };
    }
    for (Assignment assignment in course.assignments.reversed) {
      if (assignment.notes.toLowerCase().contains("not for grading")) {
        continue;
      }
      categoryMap[assignment.category]["earnedPoints"] +=
          assignment.earnedPoints;
      categoryMap[assignment.category]["possiblePoints"] +=
          assignment.possiblePoints;
      double cumPercent = 0.0;
      double cumWeightage = 0.0;
      for (dynamic cat in categoryMap.values) {
        if (cat["possiblePoints"] > 0) {
          cumPercent += (100 * cat["earnedPoints"] / cat['possiblePoints']) *
              (cat["weight"] / 100);
          cumWeightage += (cat["weight"] / 100);
        }
      }

      res.add(GPAData(cumPercent / cumWeightage));
    }
    return res;
  }

  List<FlSpot> constructSpots(List<dynamic> points) {
    List<FlSpot> res = [];
    double inc = 1;
    for (dynamic point in points) {
      GPAData gpaPoint = GPAData.fromMap(point);
      res.add(FlSpot(inc, gpaPoint.gpa));
      inc += 1;
    }

    return res;
  }

  void orderAssignments(List<Assignment> unordered) {
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    unordered.sort((a, b) {
      DateTime dateA = dateFormat.parse(a.date);
      DateTime dateB = dateFormat.parse(b.date);
      return dateB.compareTo(dateA);
    });
  }

  dynamic constructCategories2(
      SchoolClass course, List<Assignment> assignments) {
    dynamic res = {};

    for (AssignmentCategory category in course.assignmentCategories) {
      if (category.name != null && category.weight != 100.00) {
        res[category.name] = {
          "name": category.name,
          "weight": category.weight,
          "earnedPoints": category.earnedPoints,
          "possiblePoints": category.possiblePoints,
        };
      }
    }
    if (res.length == 0) {
      //loop through each assignment and create/modify assignmetn weights + earnedPoints / possiblePoints
      for (Assignment assignment in assignments) {
        if (res.containsKey(assignment.category)) {
          res[assignment.category]['possiblePoints'] +=
              assignment.possiblePoints;
          res[assignment.category]['earnedPoints'] += assignment.earnedPoints;
        } else {
          res[assignment.category] = {
            "name": assignment.category,
            "weight": 50.0,
            "earnedPoints": assignment.earnedPoints,
            "possiblePoints": assignment.possiblePoints,
          };
        }
      }
      for (var category in res.values) {
        category['weight'] = 100 / res.length;
      }
      return constructAssignmentCategories(res);
    }

    bool needsChanging = true;
    if (assignments.isNotEmpty) {
      for (var cat in res.values) {
        if (cat['possiblePoints'] > 0) {
          needsChanging = false;
          break;
        }
      }
    }
    if (needsChanging) {
      for (Assignment assignment in assignments) {
        res[assignment.category]['possiblePoints'] += assignment.possiblePoints;
        res[assignment.category]['earnedPoints'] += assignment.earnedPoints;
      }
    }

    return constructAssignmentCategories(res);

    return res;
  }

  Future<String?> testQuery(String email, String password) async {
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));

    return studentData.formattedName;
  }

  createData(assignments, categories) {
    // List to store GPA and dates
    List<Map<String, dynamic>> gpaHistory = [];

    // Define the date format for parsing the assignment dates
    DateFormat inputDateFormat = DateFormat('M/d/yyyy');

    // Loop through assignments
    for (var assignment in assignments) {
      String category = assignment['category'];
      double earnedPoints = assignment['earnedPoints'];
      double possiblePoints = assignment['possiblePoints'];

      // Update category points by subtracting assignment's points
      if (categories.containsKey(category)) {
        categories[category]!['earnedPoints'] =
            (categories[category]!['earnedPoints'] ?? 0) - earnedPoints;
        categories[category]!['possiblePoints'] =
            (categories[category]!['possiblePoints'] ?? 0) - possiblePoints;
      }

      // Recalculate GPA based on updated category values
      double cumulativeGPA = 0.0;
      for (var cat in categories.entries) {
        double catEarned = cat.value['earnedPoints'] ?? 0;
        double catPossible = cat.value['possiblePoints'] ?? 0;
        double catWeight = cat.value['weight'] ?? 0;

        if (catPossible > 0) {
          cumulativeGPA += (catEarned / catPossible) * (catWeight / 100);
        }
      }
      // Convert GPA to 4.0 scale
      cumulativeGPA *= 4.0;

      // Parse the date using the inputDateFormat
      DateTime parsedDate = inputDateFormat.parse(assignment['date']);

      // Add the calculated GPA and date to the history list
      gpaHistory.add({
        'date': DateFormat('M/d/yyyy').format(parsedDate),
        'gpa': cumulativeGPA,
      });
    }
  }

  List<AssignmentCategory> constructAssignmentCategories(dynamic res) {
    List<AssignmentCategory> constructed = [];
    for (var cat in res.values) {
      constructed.add(AssignmentCategory.fromMap(cat));
    }
    return constructed;
  }
}
