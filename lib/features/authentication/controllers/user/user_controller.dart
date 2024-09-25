import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/GPAData.dart';
import 'package:grades/features/authentication/screens/login/login.dart';
import 'package:studentvueclient/studentvueclient.dart';

import '../../../../common/data/GPAHistory.dart';

class GenesisUserController extends GetxController {
  //vars

  Map<String, dynamic> userdata = {
    "name": "",
    "stats": {"apcount": 0, "rank": 15, "absences": 4},
    "courses": {},
    "assignments": [],
  };

  var localStorage = GetStorage();
  //"history": {"overall": {curDate, "4.43"
  Map<String, String> gpas = <String, String>{"overall": "4.51"};
  Map<String, GPAHistory> history = <String, GPAHistory>{};

  String gpaGoal = "4.40";

  //methods

  //void getWeekTrend(String course) #accesses local storage and does a bnch of math

  //void getMonthTrend(String course)

  //void getSemesterTrend(String course)

  //void getGradebook() => Map<String, Map<String, String>> ex. {"Multi": {"letter": "A", "percent": "92.5"}}

  //void getStats() =>

  String getGPAGoal() {
    return gpaGoal;
  }

  String getGPA() {
    var gpaHistory = localStorage.read("GPA_HISTORY");
    List<GPAData> gpaList = (gpaHistory['overall'] as List)
        .map((item) => GPAData.fromMap(item))
        .toList();
    return gpaList.last.gpa.toStringAsFixed(3);
}

  String? amntFromGoal() {
    double amount = double.parse(getGPA()) - double.parse(getGPAGoal());
    return amount.toStringAsFixed(2);
  }

  String getClassRank() {
    return userdata["stats"]["rank"].toString();
  }

  Map<String, String> getAttendance() {
    return {"percent": "95%", "num": userdata["stats"]["absences"].toString()};
  }

  String getAPCount() {
    return userdata["stats"]["apcount"].toString();
  }
}
