import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/reset_password_remote_source.dart';
import 'package:speedy_chow/features/auth/data/models/reset_password_model.dart';

class ResetPasswordRemoteSourceImpl implements ResetPasswordRemoteSource{
 
  @override
  Future<ApiResponse?> resetPassword({required Map<String, dynamic> data}) async{
     return await DioRequest.patch(AppUrl.resetPassword,data: data, createResponseModel: ResetPasswordModel.createResponseModel);
  }

}