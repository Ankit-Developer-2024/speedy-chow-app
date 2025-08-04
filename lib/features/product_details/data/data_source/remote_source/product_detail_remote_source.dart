import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class ProductDetailRemoteSource{
  Future<ApiResponse?> fetchProductDetails({required String id});
}