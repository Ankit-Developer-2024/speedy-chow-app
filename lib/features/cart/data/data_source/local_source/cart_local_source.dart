import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class CartLocalSource{
  Future<ApiResponse?> fetchUserCart(String userId);
}