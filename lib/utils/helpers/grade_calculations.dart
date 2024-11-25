import 'package:grades/common/data/GPAData.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:studentvueclient/studentvueclient.dart';

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

  static double calculateCumulativeGPA(User user, int curQuarter) {
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
      case 'D-':
        return 0.7 + boost;
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

  static double calculateGradeOn(
      //TODO: implement
      {required DateTime date,
      required ClassData course}) {
    double cumPercent = 0.0;
    double cumWeightage = 0.0;
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
      if (GenesisHelpers.stringToDateTime(assignment.date).isAfter(date)) {
        continue; // not break since ordering can be weird
      }
      if (assignment.notes.toLowerCase().contains("not for grading")) {
        continue;
      }
      categoryMap[assignment.category]["earnedPoints"] +=
          assignment.earnedPoints;
      categoryMap[assignment.category]["possiblePoints"] +=
          assignment.possiblePoints;
    }
    for (dynamic cat in categoryMap.values) {
      if (cat["possiblePoints"] > 0) {
        cumPercent += (100 * cat["earnedPoints"] / cat['possiblePoints']) *
            (cat["weight"] / 100);
        cumWeightage += (cat["weight"] / 100);
      }
    }
    if (cumWeightage == 0) {
      return -1;
    }
    return cumPercent / cumWeightage;
  }
}
