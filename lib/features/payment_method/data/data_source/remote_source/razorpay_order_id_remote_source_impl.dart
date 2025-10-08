import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/razorpay_order_id_remote_source.dart';
import 'package:speedy_chow/features/payment_method/data/models/razorpay_order_id_model.dart';

class RazorpayOrderIdRemoteSourceImpl implements RazorpayOrderIdRemoteSource{
  @override
  Future<ApiResponse?> razorpayOrderId({required Map<String,dynamic> data}) async{
     return await DioRequest.post(AppUrl.razorpayOrderId,data: data ,createResponseModel: RazorpayOrderIdModel.createResponseModel);
  }

}