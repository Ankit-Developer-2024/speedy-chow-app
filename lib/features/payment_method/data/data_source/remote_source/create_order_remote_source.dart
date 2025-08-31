import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class CreateOrderRemoteSource{
  Future<ApiResponse?> createOrder({required Map<String,dynamic> data});
}