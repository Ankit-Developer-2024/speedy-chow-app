import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class AddProductToCartRepo{
  Future<ApiResponse?> addToCart({required Map<String,dynamic> data});
}