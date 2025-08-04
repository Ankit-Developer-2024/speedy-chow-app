
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/product_detail_remote_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository{
  final ProductDetailLocalSource productDetailLocalSource;
  final ProductDetailRemoteSource productDetailRemoteSource;

  ProductDetailRepositoryImpl({required this.productDetailLocalSource,required this.productDetailRemoteSource});
  @override
  Future<ApiResponse?> fetchProduct({required String productId}) async{
     return await productDetailRemoteSource.fetchProductDetails(id: productId);
     return await productDetailLocalSource.fetchProduct(productId);
  }

}