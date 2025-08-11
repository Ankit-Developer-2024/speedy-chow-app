import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class FetchCartProductsRepo{
  Future<ApiResponse?> fetchCartProducts();
}