import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/cart/data/data_source/remote_source/update_cart_remote_source.dart';
import 'package:speedy_chow/features/cart/data/models/cart_model.dart';

class UpdateCartRemoteSourceImpl implements UpdateCartRemoteSource{
  @override
  Future<ApiResponse?> updateCartQuantity({required String cartId, required Map<String, dynamic> data}) async{
    ApiResponse? response= await DioRequest.patch("${AppUrl.cart}/$cartId",data: data ,createResponseModel: CartModel.createResponseModel);
    return response;
  }
}