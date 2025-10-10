import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/home/domain/repositories/search_product_repo.dart';

class SearchProductUseCase implements UseCase<ApiResponse,SearchProductUseCaseParam>{
  final SearchProductRepo searchProductRepo;

  SearchProductUseCase({required this.searchProductRepo});
  @override
  Future<ApiResponse?> call(SearchProductUseCaseParam params) async{
    return await searchProductRepo.searchProduct(data: params.toJson());
  }

}

class SearchProductUseCaseParam{
  final String name;

  SearchProductUseCaseParam({required this.name});

  Map<String,dynamic> toJson(){
    return {'qName':name};
  }
}