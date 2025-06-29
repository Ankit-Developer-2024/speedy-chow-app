
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository{
  final ProductDetailLocalSource productDetailLocalSource;

  ProductDetailRepositoryImpl({required this.productDetailLocalSource});
  @override
  Future<ApiResponse?> fetchProduct(String productId) async{
     return await productDetailLocalSource.fetchProduct(productId);
  }

}