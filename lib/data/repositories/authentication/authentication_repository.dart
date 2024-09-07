import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/features/authentication/screens/login/login.dart';
import 'package:grades/features/authentication/screens/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/exceptions/firebase_auth_exceptions.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect({loggedIn = false}) async {
    final user = _auth.currentUser;

    if (loggedIn) {

      Get.offAll(() => const NavigationMenu());
      return;
    }

    deviceStorage.writeIfNull('isFirstTime', true);

    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw GenesisFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GenesisFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GenesisFormatException();
    } on PlatformException catch (e) {
      throw GenesisPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
