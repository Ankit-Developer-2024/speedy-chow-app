import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class VerifyOtpRemoteSource {
  Future<ApiResponse?> verifyOtp({required Map<String,dynamic> data});
}
