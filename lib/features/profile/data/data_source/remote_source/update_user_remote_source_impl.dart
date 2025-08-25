
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/features/profile/data/data_source/remote_source/update_user_remote_source.dart';

class UpdateUserRemoteSourceImpl implements UpdateUserRemoteSource{
  @override
  Future<ApiResponse?> updateUser({required Map<String, dynamic> data}) async{
     ApiResponse? response=await DioRequest.patch(AppUrl.user,data: data ,createResponseModel: UserModel.createResponseModel);
     return response;
  }
}