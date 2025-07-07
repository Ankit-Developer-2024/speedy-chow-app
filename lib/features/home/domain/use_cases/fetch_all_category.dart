
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/home/domain/repositories/category_repository.dart';

class FetchAllCategory implements UseCase<ApiResponse,NoParams>{
  final CategoryRepository categoryRepository;

  FetchAllCategory({required this.categoryRepository});

  @override
  Future<ApiResponse?> call(NoParams params) async{
     return await categoryRepository.fetchAllCategory();
  }

}