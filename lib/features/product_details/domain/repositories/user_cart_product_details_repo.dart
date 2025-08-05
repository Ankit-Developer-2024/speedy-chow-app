import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UserCartProductDetailsRepo{
  Future<ApiResponse?> fetchUserCartProduct({required String productId});
}