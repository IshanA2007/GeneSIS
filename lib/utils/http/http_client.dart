import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:intl/intl.dart';

class GenesisHttpClient {
  GenesisUserController user = Get.find<GenesisUserController>();
  List<dynamic> unorderedAssignments = [];

  static void handleGrade(double grade) {
    var gr = grade * 100;
    print('Process is $gr percent complete');
  }

  Future<void> queryStudentVue(String email, String password) async {
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentGradeData gradebook =
        await client.loadGradebook(callback: (handleGrade));
    StudentData studentData = await client.loadStudentData(callback: (handleGrade));

    user.userdata["name"] = studentData.formattedName!.split(" ")[0];

    for (SchoolClass course in gradebook.classes) {
      if (course.className.contains("AP")) {
        user.userdata['stats']['apcount'] += 1;
      }
      var assignments = constructAssignments(course);
      var categories = constructCategories(course, assignments);


      user.userdata["courses"][course.className] = {
        "missing": "2",
        "letter": assignments.isEmpty ? "N/A" :  GenesisGradeCalculations.percentToLetter(
            double.parse(course.pctGrade!)),
        "percent": course.pctGrade!,
        "categories": categories,
        "assignments": assignments,
      };
    }

    constructOrderedAssignments(unorderedAssignments);




    return;
  }

  void constructOrderedAssignments(dynamic unordered){
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    unordered.sort((a, b) {
      DateTime dateA = dateFormat.parse(a['date']);
      DateTime dateB = dateFormat.parse(b['date']);
      return dateB.compareTo(dateA);
    });
    user.userdata['assignments'] = unordered;
  }

  dynamic constructCategories(SchoolClass course, dynamic assignments) {
    dynamic res = {};

    for (AssignmentCategory category in course.assignmentCategories) {
      if (category.name != null && category.weight != 100.00) {
        res[category.name] = {
          "weight": category.weight,
          "earnedPoints": category.earnedPoints,
          "possiblePoints": category.possiblePoints,
        };
      }
    }
    if (res.length == 0) {
      //loop through each assignment and create/modify assignmetn weights + earnedPoints / possiblePoints
      for (dynamic assignment in assignments) {
        if (res.containsKey(assignment['category'])) {
          res[assignment['category']]['possiblePoints'] +=
              assignment['possiblePoints'];
          res[assignment['category']]['earnedPoints'] +=
              assignment['earnedPoints'];
        } else {
          res[assignment['category']] = {
            "weight": 50.0,
            "earnedPoints": assignment['earnedPoints'],
            "possiblePoints": assignment['possiblePoints'],
          };
        }
      }
      for (var category in res.values) {
        category['weight'] = 100 / res.length;
      }
      return res;
    }

    bool needsChanging = true;
    if (assignments.length > 0) {
      for (var cat in res.values) {
        if (cat['possiblePoints'] > 0) {
          needsChanging = false;
          break;
        }
      }
    }
    if (needsChanging) {
      for (dynamic assignment in assignments) {
        res[assignment['category']]['possiblePoints'] +=
            assignment['possiblePoints'];
        res[assignment['category']]['earnedPoints'] +=
            assignment['earnedPoints'];
      }
    }

    return res;
  }

  List<Map<String, dynamic>> constructAssignments(SchoolClass course) {
    List<Map<String, dynamic>> assignmentsInCategory = [];

    for (Assignment assignment in course.assignments) {
      if (assignment.earnedPoints >= 0) {
        assignmentsInCategory.add({
          "name": assignment.assignmentName,
          "date": assignment.date,
          "earnedPoints": assignment.earnedPoints,
          "possiblePoints": assignment.possiblePoints,
          "category": assignment.category,
          "notes": assignment.notes,
          "course": course.className,
        });
        unorderedAssignments.add({
          "name": assignment.assignmentName,
          "date": assignment.date,
          "earnedPoints": assignment.earnedPoints,
          "possiblePoints": assignment.possiblePoints,
          "category": assignment.category,
          "notes": assignment.notes,
          "course": course.className,
        });
      }
    }
    return assignmentsInCategory;
  }

  Future<String?> testQuery(String email, String password) async {
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));
    print(studentData.formattedName);
    return studentData.formattedName;
  }
}
