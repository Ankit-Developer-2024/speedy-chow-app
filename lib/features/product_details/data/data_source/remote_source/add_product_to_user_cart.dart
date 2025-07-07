import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class AddProductToUserCart{
  Future<ApiResponse> addProductToCart(String productId);

}