import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/category_local_source.dart';
import 'package:speedy_chow/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryLocalSource categoryLocalSource;

  CategoryRepositoryImpl({required this.categoryLocalSource});

  @override
  Future<ApiResponse?> fetchAllCategory() async{
    return await categoryLocalSource.fetchAllCategory();
  }

}
