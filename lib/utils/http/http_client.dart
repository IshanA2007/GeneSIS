import 'package:studentvueclient/studentvueclient.dart';


class GenesisHttpClient{

  static void handleGrade(double grade) {
    var gr = grade * 100;
    print('Process is $gr percent complete');
  }

  static Future<void> queryStudentVue(String email, String password) async{
    var client = StudentVueClient(email, password, 'sisstudent.fcps.edu');
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    print(await client.loadStudentData(callback: (handleGrade)));
    return;
  }
}


