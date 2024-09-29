
import 'package:get/get.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';

import '../../common/data/ClassData.dart';
import '../../common/data/Period.dart';
import '../../common/data/User.dart';

class GenesisGradeCalculations {
  static String percentToLetter(double percent) {
    if (percent >= 92.5) return "A";
    if (percent >= 89.5) return "A-";
    if (percent >= 86.5) return "B+";
    if (percent >= 82.5) return "B";
    if (percent >= 79.5) return "B-";
    if (percent >= 76.5) return "C+";
    if (percent >= 72.5) return "C";
    if (percent >= 69.5) return "C-";
    if (percent >= 66.5) return "D+";
    if (percent >= 62.5) return "D";
    if (percent >= 59.5) return "D-";
    return "F";
  }

  static double percentify(double earned, double possible) {
    return (earned / possible) * 100;
  }

  static double calculateCumulativeGPA(User user, int curQuarter){
    double outdatedGPA = user.initialCumGPA ?? 0.0;
    double creditsTaken = user.creditsTaken ?? 1.0;
    double gpaVal = outdatedGPA * creditsTaken;
    if (curQuarter == 1 || curQuarter == 2) {
      for (Period period in user.periods) {
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

  // TODO: update GPA based on semester/yearlong instead of assuming semester and forgetting last semester
  static double updateGPA(double outdatedGPA, double creditsTaken) {
    final user = Get.find<GenesisUserController>();
    final courses = user.userdata['courses'];
    print(outdatedGPA);
    print(creditsTaken);
    double gpaVal = outdatedGPA * creditsTaken;
    courses.forEach((courseName, courseData) {
      print(courseName);
      gpaVal += gpaFromLetter(courseData['letter'], courseName) * 0.5;
      creditsTaken += 0.5;
    });
    return gpaVal / creditsTaken;
  }

  static double gpaFromLetter(String letter, String courseName) {
    String normalLetter = letter.toUpperCase();
    double boost = double.parse(gpaBoostFromCourse(courseName));
    switch (normalLetter) {
      case 'A':
        return 4.0 + boost;
      case 'A-':
        return 3.7 + boost;
      case 'B+':
        return 3.3 + boost;
      case 'B':
        return 3.0 + boost;
      case 'B-':
        return 2.7 + boost;
      case 'C+':
        return 2.3 + boost;
      case 'C':
        return 2.0 + boost;
      case 'C-':
        return 1.7 + boost;
      case 'D+':
        return 1.3 + boost;
      case 'D':
        return 1.0 + boost;
      case 'F':
        return 0.0 + boost;
      default:
        throw ArgumentError('Unknown letter grade: $letter');
    }
  }

  static String gpaBoostFromCourse(String course) {
    if (course.contains("AP") || course.contains("AV")) {
      return "1.0";
    } else if (course.contains("HN") || course.contains("Honors")) {
      return "0.5";
    }
    return "0.0";
  }
}
