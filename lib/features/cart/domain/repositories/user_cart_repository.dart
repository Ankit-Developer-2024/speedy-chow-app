import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UserCartRepository{
  Future<ApiResponse?> fetchUserCart(String userId);
}