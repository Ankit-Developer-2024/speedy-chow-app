import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/fetch_orders_remote_source.dart';
import 'package:speedy_chow/features/order/data/models/order_model.dart';

class FetchOrderRemoteSourceImpl implements FetchOrderRemoteSource{
  
  @override
  Future<ApiResponse?> fetchOrders() async{
     ApiResponse? response = await DioRequest.get(AppUrl.order, createResponseModel: OrderModel.createResponseModelWithList);
     return response;
  } 
  
}