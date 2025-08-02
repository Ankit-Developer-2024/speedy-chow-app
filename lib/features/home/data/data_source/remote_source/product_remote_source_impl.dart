import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/home/data/data_source/remote_source/product_remote_source.dart';
import 'package:speedy_chow/features/home/data/models/product_model.dart';

class ProductRemoteSourceImpl implements ProductRemoteSource{
  @override
  Future<ApiResponse?> fetchAllProduct({required List<String> filterProductByName})async {
    ApiResponse? response =await DioRequest.get<List<ProductModel>>(AppUrl.fetchProduct,queryParam: {"category":filterProductByName},createResponseModel: ProductModel.createResponseModel);
    return response;
  }
}