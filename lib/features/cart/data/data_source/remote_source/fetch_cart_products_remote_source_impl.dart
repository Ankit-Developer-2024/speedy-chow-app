import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/cart/data/data_source/remote_source/fetch_cart_products_remote_source.dart';
import 'package:speedy_chow/features/cart/data/models/cart_model.dart';

class FetchCartProductsRemoteSourceImpl implements FetchCartProductsRemoteSource{
  @override
  Future<ApiResponse?> fetchCartProducts() async{
    ApiResponse? response= await DioRequest.get(AppUrl.fetchCart, createResponseModel: CartModel.createResponseModelWithList);
    return response;
  }
}