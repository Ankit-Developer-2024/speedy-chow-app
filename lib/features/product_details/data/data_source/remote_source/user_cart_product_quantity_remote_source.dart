import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UserCartProductQuantityRemoteSource{
  Future<ApiResponse?> fetchUserCartProductQuantity({required String productId});
}