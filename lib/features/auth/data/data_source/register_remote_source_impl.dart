import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/register_remote_source.dart';

class RegisterRemoteSourceImpl implements RegisterRemoteSource{
  @override
  Future<ApiResponse?> register({required Map<String, dynamic> data}) async{
    ApiResponse? response = await DioRequest.post(AppUrl.signUp,data: data, createResponseModel: UserModel.createResponseModel);
     return response;
  }

}