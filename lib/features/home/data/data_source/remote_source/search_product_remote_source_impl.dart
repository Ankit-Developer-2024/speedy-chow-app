import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/search_product_remote_source.dart';
import 'package:speedy_chow/features/home/data/models/search_product_model.dart';

class SearchProductRemoteSourceImpl implements SearchProductRemoteSource{
  @override
  Future<ApiResponse?> searchProduct({required Map<String, dynamic> data}) async{
   return  await DioRequest.get(AppUrl.searchProduct,queryParam: data, createResponseModel: SearchProductModel.createResponseModel);
  }

}