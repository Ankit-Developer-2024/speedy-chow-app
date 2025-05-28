import 'package:speedy_chow/core/enum/enums.dart';

class AppSecretConfig{
  final Flavor flavor;
  final String name;
  final AppSecretValues? values;

  static AppSecretConfig? _instance;

  AppSecretConfig._internal(this.flavor,this.name,this.values);

  factory AppSecretConfig({Flavor? flavor,AppSecretValues? values}){
    _instance ??=AppSecretConfig._internal(flavor!, flavor.toString(), values);
    return _instance!;
  }

  static AppSecretConfig? get instance{
    return _instance;
  }
}

class AppSecretValues{
  final String baseUrl;
  final Duration timeOut;

  AppSecretValues({required this.baseUrl, required this.timeOut});

}