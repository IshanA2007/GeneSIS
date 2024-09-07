import 'package:get_storage/get_storage.dart';

class GenesisStorage {


  static String getUserId(){
    final deviceStorage = GetStorage();
    return deviceStorage.read("username");
  }
}