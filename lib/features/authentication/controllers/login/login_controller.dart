import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/data/repositories/authentication/authentication_repository.dart';
import 'package:grades/features/authentication/controllers/network/network_manager.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/popups/full_screen_loader.dart';
import 'package:grades/utils/validators/validation.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/http/http_client.dart';

class LoginController extends GetxController {
  //vars
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      GenesisFullScreenLoader.openLoadingDialog(
          "We are logging you in...", GenesisImages.loginAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GenesisFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        GenesisFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      //validate a correct SIS credential
      //final userCredentials = await AuthenticationRepository.instance
      // .loginWithEmailAndPassword(
      //     '${email.text.trim()}@fcpsschools.net', password.text.trim());

      await GenesisValidator.validateSISLogin(
          email.text.trim(), password.text.trim());

      //save username and pass to local storage for querying
      localStorage.write("username", email.text.trim());

      //query and store all necessary data
      var httpClient = GenesisHttpClient();

      await httpClient.queryStudentVue(email.text.trim(), password.text.trim());

      GenesisFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect(loggedIn: true);
    } catch (e) {
      print(e.toString());
      GenesisFullScreenLoader.stopLoading();
      GenesisLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
