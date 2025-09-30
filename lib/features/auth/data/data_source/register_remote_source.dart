import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class RegisterRemoteSource{
  Future<ApiResponse?> register({required Map<String,dynamic> data});
}