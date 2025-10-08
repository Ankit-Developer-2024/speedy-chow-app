import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class ResetPasswordReqRepo{
  Future<ApiResponse?> resetPasswordReq({required Map<String,dynamic> data});
}