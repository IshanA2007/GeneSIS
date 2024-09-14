import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/data/repositories/authentication/authentication_repository.dart';
import 'package:grades/features/authentication/controllers/network/network_manager.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/popups/full_screen_loader.dart';
import 'package:grades/utils/validators/validation.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/http/http_client.dart';

class GPAInputController extends GetxController {
  //vars
  final localStorage = GetStorage();
  final cumGPA = TextEditingController();
  final courseCreditsTaken = TextEditingController();
  GlobalKey<FormState> gpaInputFormKey = GlobalKey<FormState>();

  Future<void> submitGPAInput() async {
    try {
      GenesisFullScreenLoader.openLoadingDialog(
          "Calculating your statistics...", GenesisImages.loginAnimation);

      if (!gpaInputFormKey.currentState!.validate()) {
        GenesisFullScreenLoader.stopLoading();
        return;
      }

      localStorage.write("CUM_GPA", cumGPA.text.trim());
      localStorage.write("COURSE_CREDITS_TAKEN", courseCreditsTaken.text.trim());

      GenesisFullScreenLoader.stopLoading();
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      print(e.toString());
      GenesisFullScreenLoader.stopLoading();
      GenesisLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
