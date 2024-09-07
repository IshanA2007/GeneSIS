import 'package:get/instance_manager.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:studentvueclient/studentvueclient.dart';

class GenesisHttpClient {
  GenesisUserController user = Get.find<GenesisUserController>();

  static void handleGrade(double grade) {
    var gr = grade * 100;
    print('Process is $gr percent complete');
  }

  Future<void> queryStudentVue(String email, String password) async {
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentGradeData gradebook =
        await client.loadGradebook(callback: (handleGrade));

    for (SchoolClass course in gradebook.classes) {
      user.userdata["courses"][course.className] = {
        "missing": "2",
        "letter": GenesisGradeCalculations.percentToLetter(
            double.parse(course.pctGrade!)),
        "percent": course.pctGrade!,
        "categories": constructCategories(course),
        "assignments": constructAssignments(course)
      };
    }

    print(user.userdata);

    return;
  }

  dynamic constructCategories(SchoolClass course) {
    dynamic res = {};
    for (AssignmentCategory category in course.assignmentCategories) {
      if (category.name != null && category.weight != 100.0) {
        res[category.name] = {
          "weight": category.weight,
          "earnedPoints": category.earnedPoints,
          "possiblePoints": category.possiblePoints,
        };
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
          "earnedPoints": assignment.earnedPoints,
          "possiblePoints": assignment.possiblePoints,
          "category": assignment.category,
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
