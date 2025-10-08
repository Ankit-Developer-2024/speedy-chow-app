import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class ResetPasswordRepo{
  Future<ApiResponse?> resetPassword({required Map<String,dynamic> data});
}