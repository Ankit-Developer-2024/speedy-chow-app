
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source.dart';
import 'package:speedy_chow/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductLocalSource productLocalSource;

  ProductRepositoryImpl({
    required this.productLocalSource
});

  @override
  Future<ApiResponse?> fetchAllProduct(
      {required List<String> filterProductByName}) async{
    return await productLocalSource.fetchAllProduct(filterProductByName: filterProductByName);
  }

}