//regex stuff

import 'package:grades/utils/http/http_client.dart';
import 'package:studentvueclient/studentvueclient.dart';

class GenesisValidator {
  static String? validateEmail(String? value){
    if (value == null || value.isEmpty){
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'\d{7}');

    if (!emailRegExp.hasMatch(value)){
      return 'Invalid FCPS ID';
    }

    return null;

  }

  static String? validateEmptyText(String? fieldName, String? value){
    if (value == null || value.isEmpty){
      return '$fieldName is required.';
    }

    return null;
  }

  static Future<bool> validateSISLogin(String user, String pass) async{
    var client = GenesisHttpClient();
    if (await client.testQuery(user, pass) != null){
      return true;
    }
    throw 'Invalid StudentVue login';
  }
}