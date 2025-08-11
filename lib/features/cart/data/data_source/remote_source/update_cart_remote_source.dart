import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UpdateCartRemoteSource{
  Future<ApiResponse?> updateCartQuantity({required String cartId,required Map<String,dynamic> data});
}