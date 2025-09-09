import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class FetchOrderDetailsRepo{
  Future<ApiResponse?> fetchOrderDetails({required String orderId});
}