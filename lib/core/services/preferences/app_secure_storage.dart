import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage{
  late final FlutterSecureStorage storage ;
  AppSecureStorage._privateConstructor(){
    storage= FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  }

  static final AppSecureStorage instance=AppSecureStorage._privateConstructor();

  Future<void> saveBothToken({required String accessToken, required String refreshToken})async{
    await storage.write(key: "accessToken", value: accessToken);
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  Future<void> saveAccessToken({required String accessToken})async{
    await storage.write(key: "accessToken", value: accessToken);
  }

  Future<void> saveRefreshToken({required String refreshToken})async{
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: "accessToken");
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: "refreshToken");
  }

  Future<void> clearBothToken() async {
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }

  Future<void> clearAccessToken() async {
    await storage.delete(key: "accessToken");
  }

  Future<void> clearRefreshToken() async {
    await storage.delete(key: "refreshToken");
  }

  Future<void> clearStorage() async {
    await storage.deleteAll();
  }


}