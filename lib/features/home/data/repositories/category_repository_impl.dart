import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/home/data/data_source/local_source/category_local_source.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/category_remote_source.dart';
import 'package:speedy_chow/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryLocalSource categoryLocalSource;
  final CategoryRemoteSource categoryRemoteSource;

  CategoryRepositoryImpl({required this.categoryLocalSource,required this.categoryRemoteSource});

  @override
  Future<ApiResponse?> fetchAllCategory() async{
    return await categoryRemoteSource.fetchAllCategory();
  }

}
