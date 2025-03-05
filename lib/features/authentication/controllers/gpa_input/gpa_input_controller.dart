import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/ClassData.dart';
import 'package:grades/common/data/GPAData.dart';
import 'package:grades/common/data/Period.dart';
import 'package:grades/common/data/User.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:grades/utils/popups/full_screen_loader.dart';

import '../../../../common/data/History.dart';
import '../../../../common/widgets/loaders/loaders.dart';

class GPAInputController extends GetxController {
  //vars
  final localStorage = GetStorage();
  final cumGPA = TextEditingController();
  final courseCreditsTaken = TextEditingController();
  GlobalKey<FormState> gpaInputFormKey = GlobalKey<FormState>();
  final user = Get.find<GenesisUserController>();

  void reconstructHistory(
      History history, User curUser, DateTime startDate, DateTime endDate) {
    List<DateTime> dateList =
        GenesisHelpers.generateDateList(startDate, endDate);

    for (DateTime date in dateList) {
      double outdatedGPA = curUser.initialCumGPA ?? 4.43;
      double creditsTaken = curUser.creditsTaken ?? 26;
      double gpaVal = outdatedGPA * creditsTaken;
      int curQuarter = GenesisHelpers.getQuarterOfDate(date);
      if (curQuarter <= 2) {
        for (Period period in curUser.periods) {
          ClassData curClass =
              period.classData[GenesisHelpers.getQuarterOfDate(date) - 1];
          if (curQuarter == 1 ||
              curClass.gradebookCode == "UK" ||
              curClass.gradebookCode == "rolling") {
            double currentClassGrade =
                GenesisGradeCalculations.calculateGradeOn(
                    date: date, course: curClass);
            if (currentClassGrade != -1) {
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          currentClassGrade),
                      curClass.courseName) *
                  0.5;

              creditsTaken += 0.5;
            }
          } else {
            //quarter must be 2 and standard
            ClassData prevClass = period.classData[0];
            double currentClassGrade =
                GenesisGradeCalculations.calculateGradeOn(
                    date: date, course: curClass);
            double prevClassGrade = prevClass.percent;
            if (currentClassGrade != -1 && prevClassGrade != -1) {
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          (currentClassGrade + prevClassGrade) / 2),
                      curClass.courseName) *
                  0.5;
              creditsTaken += 0.5;
            }
          }
        }

        history.history.add(GPAData(gpaVal / creditsTaken));
      } else {
        //quarter is 3 or 4
        for (Period period in curUser.periods) {
          ClassData curQCourse = period.classData[curQuarter - 1];
          if (curQCourse.durationCode == "YR") {
            if (curQCourse.gradebookCode == "rolling") {
              double currentClassGrade =
                  GenesisGradeCalculations.calculateGradeOn(
                      date: date, course: curQCourse);
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          currentClassGrade),
                      curQCourse.courseName) *
                  1;
              creditsTaken += 1;
            } else {
              for (int prevQ = 0; prevQ < curQuarter - 1; prevQ++) {
                ClassData prevQCourse = period.classData[prevQ];
                gpaVal += GenesisGradeCalculations.gpaFromLetter(
                        GenesisGradeCalculations.percentToLetter(
                            prevQCourse.percent),
                        prevQCourse.courseName) *
                    0.25;
                creditsTaken += 0.25;
              }
              double currentClassGrade =
                  GenesisGradeCalculations.calculateGradeOn(
                      date: date, course: curQCourse);
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          currentClassGrade),
                      curQCourse.courseName) *
                  0.25;
              creditsTaken += 0.25;
            }
          } else {
            for (int qIndex = 1; qIndex < curQuarter - 1; qIndex += 2) {
              if (period.classData[qIndex].gradebookCode == "rolling") {
                gpaVal += GenesisGradeCalculations.gpaFromLetter(
                        GenesisGradeCalculations.percentToLetter(
                            period.classData[qIndex].percent),
                        period.classData[qIndex].courseName) *
                    0.5;
                creditsTaken += 0.5;
              } else {
                ClassData prevQCourse = period.classData[qIndex - 1];
                double avgGPA = (GenesisGradeCalculations.gpaFromLetter(
                            GenesisGradeCalculations.percentToLetter(
                                period.classData[qIndex].percent),
                            period.classData[qIndex].courseName) +
                        GenesisGradeCalculations.gpaFromLetter(
                            GenesisGradeCalculations.percentToLetter(
                                prevQCourse.percent),
                            prevQCourse.courseName)) /
                    2;
                gpaVal += avgGPA * 0.5;
                creditsTaken += 0.5;
              }
            }
            if (curQCourse.gradebookCode == "rolling") {
              double currentClassGrade =
                  GenesisGradeCalculations.calculateGradeOn(
                      date: date, course: curQCourse);
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          currentClassGrade),
                      curQCourse.courseName) *
                  0.5;
              creditsTaken += 0.5;
            } else {
              ClassData prevQCourse = period.classData[curQuarter - 2];
              double currentClassGrade =
                  GenesisGradeCalculations.calculateGradeOn(
                      date: date, course: curQCourse);
              double avgGPA = (GenesisGradeCalculations.gpaFromLetter(
                          GenesisGradeCalculations.percentToLetter(
                              currentClassGrade),
                          curQCourse.courseName) +
                      GenesisGradeCalculations.gpaFromLetter(
                          GenesisGradeCalculations.percentToLetter(
                              prevQCourse.percent),
                          prevQCourse.courseName)) /
                  2;
              gpaVal += avgGPA * 0.5;
              creditsTaken += 0.5;
            }
          }
        }
      }
    }
  }

  Future<void> submitGPAInput() async {
    try {
      GenesisFullScreenLoader.openLoadingDialog(
          "Calculating your statistics...", GenesisImages.loginAnimation);

      if (!gpaInputFormKey.currentState!.validate()) {
        GenesisFullScreenLoader.stopLoading();
        return;
      }

      //write initialCumGPA and courseCreditsTaken to local storage

      localStorage.writeIfNull("initialCumGPAs", {});
      Map<dynamic, dynamic> initialCumGPAs = localStorage.read("initialCumGPAs");
      initialCumGPAs[localStorage.read("username")] =
          double.parse(cumGPA.text.trim());
      localStorage.write("initialCumGPAs", initialCumGPAs);

      user.curUser!.initialCumGPA = double.parse(cumGPA.text.trim());

      localStorage.writeIfNull("courseCreditsTakens", {});
      Map<dynamic, dynamic> courseCreditsTakens =
          localStorage.read("courseCreditsTakens");
      courseCreditsTakens[localStorage.read("username")] =
          double.parse(courseCreditsTaken.text.trim());
      localStorage.write("courseCreditsTakens", courseCreditsTakens);

      user.curUser!.creditsTaken = double.parse(courseCreditsTaken.text.trim());

      //reconstruct the overall history of the user
      History overallHistory = user.curUser!.history
          .firstWhere((history) => history.name == "overall");
      // overallHistory.history.insert(0, GPAData(updatedCGPA));

      User curUser = user.curUser!;
      DateTime startDate = DateTime(2024, 8, 19); // TODO: don't hardcode start date

      // Get the current date
      DateTime endDate = DateTime.now();

      reconstructHistory(overallHistory, curUser, startDate, endDate);

      await user.addOrReplaceDocument(
          localStorage.read("username"), overallHistory.history.last.gpa);
      Map<String, int> ranking =
          await user.getGpaRanking(overallHistory.history.last.gpa);
      curUser.rank = ranking;

      Map<dynamic, dynamic> users = localStorage.read("users");
      users[localStorage.read("username")] = user.curUser!.toMap();
      localStorage.write("users", users);
      localStorage.write(
          "COURSE_CREDITS_TAKEN", courseCreditsTaken.text.trim());

      GenesisFullScreenLoader.stopLoading();
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      print(e.toString());
      GenesisFullScreenLoader.stopLoading();
      GenesisLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
