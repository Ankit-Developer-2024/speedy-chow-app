import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UserCartProductDetailsRemoteSource{
  Future<ApiResponse?> fetchUserCartProductDetails({required String id});
}