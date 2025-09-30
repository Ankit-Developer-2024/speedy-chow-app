import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UpdateOrderRemoteSource{
  Future<ApiResponse?> updateOrder({required String id ,required Map<String,dynamic> data});
}