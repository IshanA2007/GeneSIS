import 'package:fl_chart/fl_chart.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/common/data/ClassData.dart';
import 'package:grades/common/data/Period.dart';
import 'package:grades/common/data/User.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:studentvueclient/studentvueclient.dart';
import 'package:intl/intl.dart';

import '../../common/data/GPAData.dart';
import '../../common/data/History.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GenesisHttpClient {
  GenesisUserController user = Get.find<GenesisUserController>();
  List<dynamic> unorderedAssignments = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static void handleGrade(double grade) {
    var gr = grade * 100;
  }

  Future<void> queryStudentVue(String email, String password) async {
    bool newAssignmentsReturned = false;
    List<String> classesWithUpdatedAssignments = [];
    var localStorage = GetStorage();
    int currentQuarter = 1;
    bool isFirstTime = false;

    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentGradeData currentGb =
        await client.loadGradebook(callback: handleGrade);
    int absences = await client.getAbsences(callback: handleGrade);

    //if user doesn't exist for current user id, create a new user
    localStorage.writeIfNull("users", {});
    Map<dynamic, dynamic> users = localStorage.read("users");
    if (!users.containsKey(email)) {
      isFirstTime = true;
      users[email] = (await makeUser2(email, password, currentGb)).toMap();
      localStorage.write("users", users);
    }

    User curUser = User.fromMap(localStorage.read("users")[email]);

    //update absences

    if (absences != curUser.absences) {
      curUser.absences = absences;
    }

    //TODO: check if any gbTypes are UK, and if so try again

    // update allAssignments, assignments, and percents of each class
    for (Period period in curUser.periods) {
      ClassData curClass = period.classData.last;

      print(curClass);

      SchoolClass foundClass = currentGb.classes.firstWhere(
          (schoolClass) => schoolClass.className == curClass.courseName);

      //update assignments
      List<Assignment> curAssignments = [];
      for (Assignment assignment in foundClass.assignments) {
        if (assignment.possiblePoints >= 0 && assignment.earnedPoints >= 0) {
          if (!curUser.assignments.contains(assignment)) {
            curUser.assignments.insert(0, assignment);
          }
          curAssignments.add(assignment);
        }
      }

      curClass.assignments = curAssignments;

      List<AssignmentCategory> categories =
          constructCategories2(foundClass, curClass.assignments);

      curClass.categories = categories;

      curClass.percent = double.parse(foundClass.pctGrade!);

      orderAssignments(curUser.assignments);
    }

    //calculate cumulative GPA, add it to history

    if (!isFirstTime) {
      History overallHistory =
          curUser.history.firstWhere((history) => history.name == "overall");
      overallHistory.history
          .add(GPAData(calculateCumulativeGPA(curUser, currentQuarter)));
      user.addOrReplaceDocument(email, overallHistory.history.last.gpa);
      Map<String, int> ranking =
          await user.getGpaRanking(overallHistory.history.last.gpa);
      curUser.rank = ranking;
    }

    // update history of user
    for (Period period in curUser.periods) {
      ClassData curClass = period.classData[period.classData.length - 1];
      History classHistory = curUser.history
          .firstWhere((history) => history.name == curClass.courseName);
      classHistory.history.add(GPAData(curClass.percent));
    }

    users = localStorage.read("users");
    users[email] = curUser.toMap();
    localStorage.write("users", users);
    return;
  }

  double calculateCumulativeGPA2(User curUser, int curQuarter) {
    //double outdatedGPA = curUser.initialCumGPA ?? 0.0;
    //double creditsTaken = curUser.creditsTaken ?? 1.0;
    double outdatedGPA = curUser.initialCumGPA ?? 4.43;
    double creditsTaken = curUser.creditsTaken ?? 26;
    double gpaVal = outdatedGPA * creditsTaken;

    if (curQuarter <= 2) {
      for (Period period in curUser.periods) {
        ClassData curQCourse = period.classData[curQuarter - 1];
        if (curQuarter == 1 ||
            curQCourse.gradebookCode == "UK" ||
            curQCourse.gradebookCode == "rolling") {
          gpaVal += GenesisGradeCalculations.gpaFromLetter(
                  GenesisGradeCalculations.percentToLetter(curQCourse.percent),
                  curQCourse.courseName) *
              0.5;
          creditsTaken += 0.5;
        } else {
          //always second quarter now bc we chekced for 1 quarter above
          ClassData prevQCourse = period.classData[curQuarter - 2];

          double avgGPA = (GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          curQCourse.percent),
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
    } else {
      for (Period period in curUser.periods) {
        ClassData curQCourse = period.classData[curQuarter - 1];
        if (curQCourse.durationCode == "YR") {
          if (curQCourse.gradebookCode == "rolling") {
            gpaVal += GenesisGradeCalculations.gpaFromLetter(
                    GenesisGradeCalculations.percentToLetter(
                        curQCourse.percent),
                    curQCourse.courseName) *
                1;
            creditsTaken += 1;
          } else {
            for (int prevQ = 0; prevQ < curQuarter; prevQ++) {
              ClassData prevQCourse = period.classData[prevQ];
              gpaVal += GenesisGradeCalculations.gpaFromLetter(
                      GenesisGradeCalculations.percentToLetter(
                          prevQCourse.percent),
                      prevQCourse.courseName) *
                  0.25;
              creditsTaken += 0.25;
            }
          }
        } else {
          for (int qIndex = 1; qIndex < curQuarter; qIndex += 2) {
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
        }
      }
    }
    return gpaVal / creditsTaken;
  }

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

  double calculateCumulativeGPA(User curUser, int curQuarter) {
    double outdatedGPA = curUser.initialCumGPA ?? 0.0;
    double creditsTaken = curUser.creditsTaken ?? 1.0;
    double gpaVal = outdatedGPA * creditsTaken;
    if (curQuarter == 1 || curQuarter == 2) {
      for (Period period in curUser.periods) {
        ClassData curClass = period.classData[period.classData.length - 1];
        if (curClass.gradebookCode == "UK" ||
            curClass.gradebookCode == "rolling") {
          if(curClass.assignments.isNotEmpty){
            gpaVal += GenesisGradeCalculations.gpaFromLetter(
                    GenesisGradeCalculations.percentToLetter(curClass.percent),
                    curClass.courseName) *
                0.5;
            creditsTaken += 0.5;
          }
        } else {
          //TODO: store quarterly grades in ClassData somehow
          //temp solution, just use current grade
           if(curClass.assignments.isNotEmpty){
            gpaVal += GenesisGradeCalculations.gpaFromLetter(
                    GenesisGradeCalculations.percentToLetter(curClass.percent),
                    curClass.courseName) *
                0.5;
            creditsTaken += 0.5;
           }
        }
      }
    }
    return gpaVal / creditsTaken;
  }

  Future<User> makeUser2(
      String email, String password, StudentGradeData currentGb) async {
    //keep track of all assignments for the feed
    List<Assignment> allAssignments = [];
    //figure out the current quarter
    int quarter = currentGb.quarter;

    //get a list of gradebooks, one for each quarter
    List<StudentGradeData> gradebooks = [];
    for (int curQuarter = 0; curQuarter < quarter; curQuarter++) {
      gradebooks.add(
          await StudentVueClient(email, password, 'sisstudent.fcps.edu')
              .loadGradebook(reportPeriod: curQuarter, callback: handleGrade));
    }

    int inc = 0;

    //create periods
    List<Period> periods = [];
    for (SchoolClass course in currentGb.classes) {
      periods.add(Period(periodNum: inc + 1, classData: []));
      inc += 1;
    }

    //create the class data for each period
    inc = 0;
    for (int curQuarter = 0; curQuarter < quarter; curQuarter++) {
      for (SchoolClass course in gradebooks[curQuarter].classes) {
        List<Assignment> curAssignments = [];
        for (Assignment assignment in course.assignments) {
          if (assignment.possiblePoints >= 0 && assignment.earnedPoints >= 0) {
            curAssignments.add(assignment);
          }
        }
        allAssignments.addAll(curAssignments);

        List<AssignmentCategory> categories =
            constructCategories2(course, curAssignments);

        ClassData newClass = ClassData(
          categories: categories,
          durationCode: "UK",
          courseName: course.className,
          percent: double.parse(course.pctGrade!),
          gradebookCode: "UK",
          assignments: curAssignments,
        );
        periods[inc].classData.add(newClass);
        inc += 1;
      }
      inc = 0;
    }

    //classify the gbType of each class
    if (quarter > 1) {
      for (Period pd in periods) {
        for (int quarterIndex = 1;
            quarterIndex < pd.classData.length;
            quarterIndex += 2) {
          ClassData course = pd.classData[quarterIndex];
          ClassData prevCourse = pd.classData[quarterIndex - 1];
          if (course.assignments.isNotEmpty) {
            var firstPrevAssignment =
                prevCourse.assignments.last.assignmentName;
            var currAssignments = course.assignments;

            if (currAssignments.isEmpty ||
                currAssignments.last.assignmentName != firstPrevAssignment) {
              course.gradebookCode = "standard";
              prevCourse.gradebookCode = "standard";
            } else {
              course.gradebookCode = "rolling";
              prevCourse.gradebookCode = "rolling";
            }
          } else {
            course.gradebookCode = "standard";
            prevCourse.gradebookCode = "standard";
          }
        }
      }
    }

    //classify duration of each class
    if (quarter > 2) {
      for (Period pd in periods) {
        int repeats = 0;
        String name = "idk";
        String newname = "";
        for (int quarterIndex = 0;
            quarterIndex < pd.classData.length;
            quarterIndex++) {
          newname = pd.classData[quarterIndex].courseName;
          if (name == newname) {
            repeats++;
          }
          name = newname;
        }
        String durationCode = repeats > 1 ? "YR" : "SEM";
        for (int quarterIndex = 0;
            quarterIndex < pd.classData.length;
            quarterIndex++) {
          pd.classData[quarterIndex].durationCode = durationCode;
        }
      }
    }

    //make history
    List<History> completeHistory = [History(name: "overall", history: [])];
    for (Period period in periods) {
      List<GPAData> periodHistory = generateHistory2(period, quarter);
      History historyToAdd = History(
          name: period.classData[quarter - 1].courseName,
          history: periodHistory);
      completeHistory.add(historyToAdd);
    }

    //load student name for user

    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));

    //add all the periods to user
    User newUser = User(
      history: completeHistory,
      absences: 0,
      rank: {},
      name: studentData.formattedName!.split(" ")[0],
      assignments: allAssignments,
      periods: periods,
    );

    var localStorage = GetStorage();
    localStorage.writeIfNull("initialCumGPAs", {});
    localStorage.writeIfNull("courseCreditsTakens", {});
    if (localStorage.read("initialCumGPAs").containsKey(email)) {
      newUser.initialCumGPA = localStorage.read("initialCumGPAs")[email];
    }
    if (localStorage.read("courseCreditsTakens").containsKey(email)) {
      newUser.creditsTaken = localStorage.read("courseCreditsTakens")[email];
    }

    History overallHistory =
        newUser.history.firstWhere((history) => history.name == "overall");
    // overallHistory.history.insert(0, GPAData(updatedCGPA));

    DateTime startDate = DateTime(2024, 8, 19); // TODO - calculate dynamically

    // Get the current date
    DateTime endDate = DateTime.now();

    if (newUser.initialCumGPA != null && newUser.creditsTaken != null) {
      reconstructHistory(overallHistory, newUser, startDate, endDate);
      print("Reconstructing history because quarter changed and user exists");
    }

    return newUser;
  }

  Future<User> makeUser(
      String email, String password, StudentGradeData currentGb) async {
    //TODO: figure out a way to figure out current quarter
    List<Assignment> allAssignments = [];
    StudentGradeData? currentGb;
    bool isFirstSem = false;
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');

    //if user doesn't exist for current user id, create a new user
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));

    print("Fetching gradebooks");
    StudentGradeData quarter1 =
        await client.loadGradebook(reportPeriod: 0, callback: handleGrade);
    StudentGradeData quarter2 =
        await client.loadGradebook(reportPeriod: 1, callback: handleGrade);
    StudentGradeData? quarter3;
    StudentGradeData? quarter4;
    try {
      quarter3 =
          await client.loadGradebook(reportPeriod: 2, callback: handleGrade);
      quarter4 =
          await client.loadGradebook(reportPeriod: 3, callback: handleGrade);
    } catch (e) {
      isFirstSem = true;
    }
    currentGb = await client.loadGradebook(callback: handleGrade);
    print("Fetched gradebooks");

    //TODO: make sure q1 and q2 classes are the same (like in case of dropouts)
    List<Period> periodsToAdd = [];

    //TODO: add the first cumulative GPA to the beginning of history after it is inputted in gpa_input
    List<History> completeHistory = [History(name: "overall", history: [])];
    if (isFirstSem) {
      String durationCode = "UK";
      int inc = 0;
      for (SchoolClass course in quarter1.classes) {
        String gbType = "UK";
        if (course.assignments.isNotEmpty) {
          var firstQ1Assignment = course.assignments[0].assignmentName;
          var q2Assignments = quarter2.classes[inc].assignments;

          if (q2Assignments.isEmpty ||
              q2Assignments[0].assignmentName != firstQ1Assignment) {
            gbType = "standard";
          } else {
            gbType = "rolling";
          }
        }

        List<Assignment> curAssignments = [];
        for (Assignment assignment in currentGb.classes[inc].assignments) {
          if (assignment.possiblePoints >= 0 && assignment.earnedPoints >= 0) {
            curAssignments.add(assignment);
          }
        }

        List<AssignmentCategory> categories =
            constructCategories2(currentGb.classes[inc], curAssignments);

        ClassData newClass = ClassData(
          categories: categories,
          durationCode: durationCode,
          courseName: course.className,
          percent: double.parse(course.pctGrade!),
          gradebookCode: gbType,
          assignments: curAssignments,
        );

        Period newPeriod = Period(periodNum: inc + 1, classData: [newClass]);
        periodsToAdd.add(newPeriod);
        allAssignments.addAll(curAssignments);
        inc += 1;

        History newHistory =
            History(name: course.className, history: generateHistory(newClass));
        completeHistory.add(newHistory);
      }
    }

    User newUser = User(
      history: completeHistory,
      absences: 0,
      rank: {},
      name: studentData.formattedName!.split(" ")[0],
      assignments: allAssignments,
      periods: periodsToAdd,
    );
    return newUser;
  }

  List<GPAData> generateHistory2(Period period, int quarter) {
    List<GPAData> res = [];
    if (period.classData[quarter - 1].durationCode == "YR") {
      if (period.classData[quarter - 1].gradebookCode == "rolling") {
        res.addAll(generateHistory(period.classData[quarter - 1]));
        return res;
      }
      for (int prevQ = 0; prevQ < quarter; prevQ++) {
        res.addAll(generateHistory(period.classData[prevQ]));
      }
      return res;
    } else {
      if ((quarter == 2 || quarter == 4) &&
          period.classData[quarter - 1].gradebookCode != "rolling") {
        ClassData priorQuarterClass = period.classData[quarter - 2];
        res.addAll(generateHistory(priorQuarterClass));
      }
      res.addAll(generateHistory(period.classData[quarter - 1]));
      return res;
    }
  }

  List<GPAData> generateHistory(ClassData course) {
    //goes from most recent to least recent

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
      if (assignment.notes.toLowerCase().contains("not for grading")) {
        continue;
      }
      categoryMap[assignment.category]["earnedPoints"] +=
          assignment.earnedPoints;
      categoryMap[assignment.category]["possiblePoints"] +=
          assignment.possiblePoints;
      double cumPercent = 0.0;
      double cumWeightage = 0.0;
      for (dynamic cat in categoryMap.values) {
        if (cat["possiblePoints"] > 0) {
          cumPercent += (100 * cat["earnedPoints"] / cat['possiblePoints']) *
              (cat["weight"] / 100);
          cumWeightage += (cat["weight"] / 100);
        }
      }

      res.add(GPAData(cumPercent / cumWeightage));
    }
    return res;
  }

  List<FlSpot> constructSpots(List<dynamic> points) {
    List<FlSpot> res = [];
    double inc = 1;
    for (dynamic point in points) {
      GPAData gpaPoint = GPAData.fromMap(point);
      res.add(FlSpot(inc, gpaPoint.gpa));
      inc += 1;
    }

    return res;
  }

  void orderAssignments(List<Assignment> unordered) {
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    unordered.sort((a, b) {
      DateTime dateA = dateFormat.parse(a.date);
      DateTime dateB = dateFormat.parse(b.date);
      return dateB.compareTo(dateA);
    });
  }

  dynamic constructCategories2(
      SchoolClass course, List<Assignment> assignments) {
    dynamic res = {};

    for (AssignmentCategory category in course.assignmentCategories) {
      if (category.name != null && category.weight != 100.00) {
        res[category.name] = {
          "name": category.name,
          "weight": category.weight,
          "earnedPoints": category.earnedPoints,
          "possiblePoints": category.possiblePoints,
        };
      }
    }
    if (res.length == 0) {
      //loop through each assignment and create/modify assignmetn weights + earnedPoints / possiblePoints
      for (Assignment assignment in assignments) {
        if (res.containsKey(assignment.category)) {
          res[assignment.category]['possiblePoints'] +=
              assignment.possiblePoints;
          res[assignment.category]['earnedPoints'] += assignment.earnedPoints;
        } else {
          res[assignment.category] = {
            "name": assignment.category,
            "weight": 50.0,
            "earnedPoints": assignment.earnedPoints,
            "possiblePoints": assignment.possiblePoints,
          };
        }
      }
      for (var category in res.values) {
        category['weight'] = 100 / res.length;
      }
      return constructAssignmentCategories(res);
    }

    bool needsChanging = true;
    if (assignments.isNotEmpty) {
      for (var cat in res.values) {
        if (cat['possiblePoints'] > 0) {
          needsChanging = false;
          break;
        }
      }
    }
    if (needsChanging) {
      for (Assignment assignment in assignments) {
        res[assignment.category]['possiblePoints'] += assignment.possiblePoints;
        res[assignment.category]['earnedPoints'] += assignment.earnedPoints;
      }
    }

    return constructAssignmentCategories(res);
  }

  Future<String?> testQuery(String email, String password) async {
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    StudentData studentData =
        await client.loadStudentData(callback: (handleGrade));

    return studentData.formattedName;
  }

  createData(assignments, categories) {
    // List to store GPA and dates
    List<Map<String, dynamic>> gpaHistory = [];

    // Define the date format for parsing the assignment dates
    DateFormat inputDateFormat = DateFormat('M/d/yyyy');

    // Loop through assignments
    for (var assignment in assignments) {
      String category = assignment['category'];
      double earnedPoints = assignment['earnedPoints'];
      double possiblePoints = assignment['possiblePoints'];

      // Update category points by subtracting assignment's points
      if (categories.containsKey(category)) {
        categories[category]!['earnedPoints'] =
            (categories[category]!['earnedPoints'] ?? 0) - earnedPoints;
        categories[category]!['possiblePoints'] =
            (categories[category]!['possiblePoints'] ?? 0) - possiblePoints;
      }

      // Recalculate GPA based on updated category values
      double cumulativeGPA = 0.0;
      for (var cat in categories.entries) {
        double catEarned = cat.value['earnedPoints'] ?? 0;
        double catPossible = cat.value['possiblePoints'] ?? 0;
        double catWeight = cat.value['weight'] ?? 0;

        if (catPossible > 0) {
          cumulativeGPA += (catEarned / catPossible) * (catWeight / 100);
        }
      }
      // Convert GPA to 4.0 scale
      cumulativeGPA *= 4.0;

      // Parse the date using the inputDateFormat
      DateTime parsedDate = inputDateFormat.parse(assignment['date']);

      // Add the calculated GPA and date to the history list
      gpaHistory.add({
        'date': DateFormat('M/d/yyyy').format(parsedDate),
        'gpa': cumulativeGPA,
      });
    }
  }

  List<AssignmentCategory> constructAssignmentCategories(dynamic res) {
    List<AssignmentCategory> constructed = [];
    for (var cat in res.values) {
      constructed.add(AssignmentCategory.fromMap(cat));
    }
    return constructed;
  }
}
