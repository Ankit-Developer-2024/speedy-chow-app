import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class DeleteCartRepo{
  Future<ApiResponse?> deleteCart({required String cartId});
}