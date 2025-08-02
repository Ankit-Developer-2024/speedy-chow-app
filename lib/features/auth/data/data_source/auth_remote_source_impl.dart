import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/aut_remote_source.dart';
import 'package:speedy_chow/features/auth/data/models/auth_models.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource{
  @override
  Future<ApiResponse?> login({required Map<String,dynamic> data}) async{
     ApiResponse? response=await DioRequest.post(AppUrl.login, createResponseModel: AuthModels.createResponseModel,data:data );
    return response;
  }

}