
import 'package:hive/hive.dart';

class AppPreferences{
  late final Box box ;

  static final AppPreferences instance=AppPreferences._();
  AppPreferences._(){
    box=Hive.box('speedyChow');
  }

  Future putValue(String key,dynamic value){
    return box.put(key, value);
  }

  dynamic getValue(String key,{dynamic defaultValue}){
    return box.get(key,defaultValue: defaultValue);
  }

  Future<int> clear() {
    return box.clear();
  }

}