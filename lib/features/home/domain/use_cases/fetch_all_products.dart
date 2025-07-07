
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/home/domain/repositories/product_repository.dart';

class FetchAllProduct implements UseCase<ApiResponse,ProductParams>{
  final ProductRepository productRepository;

  FetchAllProduct({required this.productRepository});

  @override
  Future<ApiResponse?> call(ProductParams params) async{
    return await productRepository.fetchAllProduct(filterProductByName: params.productName);
  }

}

class ProductParams{
  final List<String> productName;

  ProductParams({required this.productName});
}