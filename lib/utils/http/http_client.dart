import 'package:studentvueclient/studentvueclient.dart';

void handleGrade(double grade) {
  var gr = grade * 100;
  print('Process is $gr percent complete');
}

Future<void> main() async {
  var client = StudentVueClient('1620426', 'skibidi', 'sisstudent.fcps.edu');
  print(await client.loadGradebook(callback: (handleGrade)));
}
