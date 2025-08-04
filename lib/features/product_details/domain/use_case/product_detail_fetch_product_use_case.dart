
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';

class ProductDetailFetchProductUseCase implements UseCase<ApiResponse,ProductDetailParam>{
  final ProductDetailRepository productDetailRepository;

  ProductDetailFetchProductUseCase({required this.productDetailRepository});
  @override
  Future<ApiResponse?> call(ProductDetailParam params) async{
    return await productDetailRepository.fetchProduct(productId:params.productId);
  }

}

class ProductDetailParam{
  final String productId;
  ProductDetailParam({required this.productId});
}