import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/user_cart_product_details_remote_source.dart';
import 'package:speedy_chow/features/product_details/data/models/product_detail_model.dart';

class UserCartProductDetailsRemoteSourceImpl implements UserCartProductDetailsRemoteSource{

  @override
  Future<ApiResponse?> fetchUserCartProductDetails({required String id})async{
    ApiResponse? response= await DioRequest.get("${AppUrl.fetchCart}/$id", createResponseModel: ProductDetailModel.createResponseModelWithList);
    return response;
  }
}