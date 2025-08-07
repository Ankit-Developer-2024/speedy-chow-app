import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class AddProductToCartRemoteSource{
  Future<ApiResponse?> addProductToCart({required Map<String,dynamic> data});

}