import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/fetch_order_details_remote_source.dart';
import 'package:speedy_chow/features/order/data/models/order_model.dart';

class FetchOrderDetailsRemoteSourceImpl implements FetchOrderDetailsRemoteSource{
  @override
  Future<ApiResponse?> fetchOrderDetails({required String orderId}) async{
     ApiResponse? response = await DioRequest.get("${AppUrl.order}/$orderId", createResponseModel: OrderModel.createResponseModel);
     return response;
  }
}