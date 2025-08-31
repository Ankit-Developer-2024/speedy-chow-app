import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/create_order_remote_source.dart';
import 'package:speedy_chow/features/payment_method/data/models/create_order_model.dart';

class CreateOrderRemoteSourceImpl implements CreateOrderRemoteSource{

  @override
  Future<ApiResponse?> createOrder({required Map<String,dynamic> data})async{
    ApiResponse? response= await DioRequest.post(AppUrl.createOrder, createResponseModel: CreateOrderModel.createResponseModel);
     return response;
  }
}