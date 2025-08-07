import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/add_product_to_cart_remote_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/add_product_to_cart_repo.dart';

class AddProductToCartRepoImpl implements AddProductToCartRepo{
  final AddProductToCartRemoteSource addProductToCartRemoteSource;

  AddProductToCartRepoImpl({required this.addProductToCartRemoteSource});
  @override
  Future<ApiResponse?> addToCart({required Map<String, dynamic> data}) async{
     return await addProductToCartRemoteSource.addProductToCart(data: data);
  }
}