import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class ProductDetailRepository{
  Future<ApiResponse?> fetchProduct({required String productId});
}