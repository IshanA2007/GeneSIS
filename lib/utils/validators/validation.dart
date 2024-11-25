//regex stuff

import 'package:grades/utils/http/http_client.dart';

class GenesisValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'FCPS ID is required.';
    }

    final emailRegExp = RegExp(r'\d{7}');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid FCPS ID';
    }

    return null;
  }

  static String? validateCumGPA(String? gpa){
    if (gpa == null || gpa.isEmpty){
      return 'GPA is required';
    }
    double val = double.tryParse(gpa) ?? -0.1;
    if (val < 0){
      return 'Invalid Cumulative GPA entered';
    }

    return null;
  }

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  static Future<bool> validateSISLogin(String user, String pass) async {
    var client = GenesisHttpClient();
    if (await client.testQuery(user, pass) != null) {
      return true;
    }
    throw 'Invalid StudentVue login';
  }
}
