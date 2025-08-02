import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/category_remote_source.dart';
import 'package:speedy_chow/features/home/data/models/category_model.dart';

class CategoryRemoteSourceImpl implements CategoryRemoteSource{

  @override
  Future<ApiResponse?> fetchAllCategory()async{
    ApiResponse? response=await DioRequest.get(AppUrl.fetchCategory, createResponseModel: CategoryModel.createResponseModel);
    return response;
  }
}