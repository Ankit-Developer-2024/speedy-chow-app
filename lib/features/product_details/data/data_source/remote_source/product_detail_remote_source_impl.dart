import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/product_detail_remote_source.dart';
import 'package:speedy_chow/features/product_details/data/models/product_detail_model.dart';

class ProductDetailRemoteSourceImpl implements ProductDetailRemoteSource{

  @override
  Future<ApiResponse?> fetchProductDetails({required String id})async{
    ApiResponse? response= await DioRequest.get("${AppUrl.fetchProduct}/$id", createResponseModel: ProductDetailModel.createResponseModel);
    return response;
  }
}