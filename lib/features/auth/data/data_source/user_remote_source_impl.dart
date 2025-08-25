import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/user_remote_source.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';

class UserRemoteSourceImpl implements UserRemoteSource{
  @override
  Future<ApiResponse?> fetchUser() async{
    ApiResponse? response =await DioRequest.get(AppUrl.user, createResponseModel:UserModel.createResponseModel );
    return response;
  }
}