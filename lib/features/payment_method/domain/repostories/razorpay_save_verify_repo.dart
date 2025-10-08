import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class RazorpaySaveVerifyRepo{
  Future<ApiResponse?>  razorpaySaveVerify({required Map<String,dynamic> data});
}