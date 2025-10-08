import 'package:speedy_chow/core/components/models/api_response.dart';

abstract  interface class RazorpayOrderIdRemoteSource{
  Future<ApiResponse?> razorpayOrderId({required Map<String,dynamic> data});
}