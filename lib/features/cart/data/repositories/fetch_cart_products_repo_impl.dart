import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/cart/data/data_source/local_source/cart_local_source.dart';
import 'package:speedy_chow/features/cart/data/data_source/remote_source/fetch_cart_products_remote_source.dart';
import 'package:speedy_chow/features/cart/domain/repositories/fetch_cart_products_repo.dart';

class FetchCartProductsRepoImpl implements FetchCartProductsRepo{
  final CartLocalSource cartLocalSource;
  final FetchCartProductsRemoteSource fetchCartProductsRemoteSource;

  FetchCartProductsRepoImpl({required this.cartLocalSource,required this.fetchCartProductsRemoteSource});
  @override
  Future<ApiResponse?> fetchCartProducts() async{
    return await fetchCartProductsRemoteSource.fetchCartProducts();
  }

}