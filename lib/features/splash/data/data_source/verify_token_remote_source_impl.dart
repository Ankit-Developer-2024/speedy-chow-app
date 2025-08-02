import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/splash/data/data_source/verify_token_remote_source.dart';
import 'package:speedy_chow/features/splash/data/models/verify_token_model.dart';

class VerifyTokenRemoteSourceImpl implements VerifyTokenRemoteSource{
  @override
  Future<ApiResponse?> verifyToken() async{
    ApiResponse? response=await DioRequest.get(AppUrl.verify, createResponseModel: VerifyTokenModel.createResponseModel);

    return response;
  }
}