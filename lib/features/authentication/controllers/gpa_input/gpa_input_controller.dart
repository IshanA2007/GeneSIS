import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/ClassData.dart';
import 'package:grades/common/data/GPAData.dart';
import 'package:grades/common/data/Period.dart';
import 'package:grades/common/data/User.dart';
import 'package:grades/data/repositories/authentication/authentication_repository.dart';
import 'package:grades/features/authentication/controllers/network/network_manager.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:grades/utils/popups/full_screen_loader.dart';
import 'package:grades/utils/validators/validation.dart';

import '../../../../common/data/History.dart';
import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/http/http_client.dart';

class GPAInputController extends GetxController {
  //vars
  final localStorage = GetStorage();
  final cumGPA = TextEditingController();
  final courseCreditsTaken = TextEditingController();
  GlobalKey<FormState> gpaInputFormKey = GlobalKey<FormState>();
  final user = Get.find<GenesisUserController>();

  Future<void> submitGPAInput() async {
    try {
      GenesisFullScreenLoader.openLoadingDialog(
          "Calculating your statistics...", GenesisImages.loginAnimation);

      if (!gpaInputFormKey.currentState!.validate()) {
        GenesisFullScreenLoader.stopLoading();
        return;
      }

      user.curUser!.initialCumGPA = double.parse(cumGPA.text.trim());
      user.curUser!.creditsTaken = double.parse(courseCreditsTaken.text.trim());

      double updatedCGPA = GenesisGradeCalculations.calculateCumulativeGPA(
          user.curUser!,
          GenesisHelpers.currentQuarter()); //TODO: calculate current quarter
      History overallHistory = user.curUser!.history
          .firstWhere((history) => history.name == "overall");
      overallHistory.history.insert(0, GPAData(updatedCGPA));

      User curUser = user.curUser!;
      DateTime startDate = DateTime(2024, 8, 19);

      // Get the current date
      DateTime endDate = DateTime.now();

      List<DateTime> dateList =
          GenesisHelpers.generateDateList(startDate, endDate);

      for (DateTime date in dateList) {
        double outdatedGPA = curUser.initialCumGPA ?? 0.0;
        double creditsTaken = curUser.creditsTaken ?? 1.0;
        double gpaVal = outdatedGPA * creditsTaken;
        if (GenesisHelpers.getQuarterOfDate(date) == 1 ||
            GenesisHelpers.getQuarterOfDate(date) == 2) {
          for (Period period in curUser.periods) {
            ClassData curClass =
                period.classData[GenesisHelpers.getQuarterOfDate(date) - 1];
            if (curClass.gradebookCode == "UK" ||
                curClass.gradebookCode == "rolling") {
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          GenesisGradeCalculations.calculateGradeOn(
                              date: date, course: curClass)),
                      curClass.courseName) *
                  0.5;
              creditsTaken += 0.5;
            } else {
              //TODO: store quarterly grades in ClassData somehow
              //temp solution, just use current grade
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          curClass.percent),
                      curClass.courseName) *
                  0.5;
              creditsTaken += 0.5;
            }
          }
        }
        overallHistory.history.add(GPAData(gpaVal / creditsTaken));

        //TODO: implement q2-q4
      }

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
