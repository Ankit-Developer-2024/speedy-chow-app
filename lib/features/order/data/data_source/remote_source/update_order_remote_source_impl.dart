import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/update_order_remote_source.dart';
import 'package:speedy_chow/features/order/data/models/order_model.dart';

class UpdateOrderRemoteSourceImpl implements UpdateOrderRemoteSource{
  @override
  Future<ApiResponse?> updateOrder({required String id, required Map<String, dynamic> data})async{
    ApiResponse? response = await DioRequest.patch("${AppUrl.order}/$id", data: data, createResponseModel: OrderModel.createResponseModel);
    return response;
  }



}