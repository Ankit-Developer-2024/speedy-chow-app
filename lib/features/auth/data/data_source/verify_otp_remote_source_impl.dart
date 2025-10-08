import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/verify_otp_remote_source.dart';
import 'package:speedy_chow/features/auth/data/models/verify_otp_model.dart';

class VerifyOtpRemoteSourceImpl implements VerifyOtpRemoteSource{
  @override
  Future<ApiResponse?> verifyOtp({required Map<String, dynamic> data}) async{
     return await DioRequest.post(AppUrl.verifyOtp,data: data ,createResponseModel: VerifyOtpModel.createResponseModel);
  }
  
}