import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/add_product_to_cart_remote_source.dart';
import 'package:speedy_chow/features/product_details/data/models/user_cart_product_quantity_model.dart';

class AddProductToCartRemoteSourceImpl implements AddProductToCartRemoteSource{
  @override
  Future<ApiResponse?> addProductToCart({required Map<String,dynamic> data}) async{
   ApiResponse? response= await DioRequest.post(AppUrl.fetchCart, data:data, createResponseModel: UserCartProductQuantityModel.createResponseModelWithMap);
   return response;
  }
}