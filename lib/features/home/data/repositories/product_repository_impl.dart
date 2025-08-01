
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/product_local_source.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/product_remote_source.dart';
import 'package:speedy_chow/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductLocalSource productLocalSource;
  final ProductRemoteSource productRemoteSource;

  ProductRepositoryImpl({
    required this.productLocalSource,
    required this.productRemoteSource,
});

  @override
  Future<ApiResponse?> fetchAllProduct(
      {required List<String> filterProductByName}) async{
    return await productRemoteSource.fetchAllProduct(filterProductByName: filterProductByName);
    return await productLocalSource.fetchAllProduct(filterProductByName: filterProductByName);
  }

}