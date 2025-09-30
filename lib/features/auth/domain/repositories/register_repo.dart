import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class RegisterRepo{
  Future<ApiResponse?> register({required Map<String,dynamic> data});
}