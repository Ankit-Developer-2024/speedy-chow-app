import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/razorpay_save_verify_remote_source.dart';
import 'package:speedy_chow/features/payment_method/data/models/razorpay_save_verify_model.dart';

class RazorpaySaveVerifyRemoteSourceImpl implements RazorpaySaveVerifyRemoteSource{
  @override
  Future<ApiResponse?> razorpaySaveVerify({required Map<String, dynamic> data}) async{
     return await DioRequest.post(AppUrl.razorpaySaveVerify,data: data, createResponseModel: RazorpaySaveVerifyModel.createResponseModel);
  }
}