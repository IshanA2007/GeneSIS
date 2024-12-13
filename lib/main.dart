import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/app.dart';
import 'package:grades/features/authentication/controllers/network/network_manager.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //Initialize Local Storage
  await GetStorage.init();

  GetStorage().remove("username");
  GetStorage().remove("password");

  //GetStorage().erase();

  //Native Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //experimental
  Get.put(NetworkManager());
  Get.put(GenesisUserController());
  GetStorage().writeIfNull("users", {});

  //Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  //Load Application
  runApp(const MainApp());
}
