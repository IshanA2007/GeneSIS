import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/loaders/animation_loader.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GenesisFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: GenesisHelpers.isDarkMode(Get.context!)
             ? Colors.black
              : Colors.white,

          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              GenesisAnimationLoaderWidget(text: text, animation: animation, showAction: false)
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
