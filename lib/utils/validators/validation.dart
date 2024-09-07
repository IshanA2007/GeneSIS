//regex stuff

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
    return true;
  }
}