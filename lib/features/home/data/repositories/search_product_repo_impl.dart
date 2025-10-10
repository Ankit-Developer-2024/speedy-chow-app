import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/search_product_remote_source.dart';
import 'package:speedy_chow/features/home/domain/repositories/search_product_repo.dart';

class SearchProductRepoImpl implements SearchProductRepo{
  final SearchProductRemoteSource searchProductRemoteSource;

  SearchProductRepoImpl({required this.searchProductRemoteSource});

  @override
  Future<ApiResponse?> searchProduct({required Map<String, dynamic> data}) async{
    return await searchProductRemoteSource.searchProduct(data: data);
  }

}