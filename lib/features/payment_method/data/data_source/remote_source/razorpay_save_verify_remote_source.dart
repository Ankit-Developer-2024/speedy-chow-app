import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class RazorpaySaveVerifyRemoteSource{
  Future<ApiResponse?> razorpaySaveVerify({required Map<String,dynamic> data});
}