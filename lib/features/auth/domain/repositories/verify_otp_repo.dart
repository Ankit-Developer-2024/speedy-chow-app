import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class VerifyOtpRepo{
  Future<ApiResponse?> verifyOtp({required Map<String,dynamic> data});
}