import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/auth/data/data_source/add_address_remote_source.dart';

class AddAddressRemoteSourceImpl implements AddAddressRemoteSource{
  @override
  Future<ApiResponse?> addAddress({required Map<String, dynamic> data}) async{
    ApiResponse? response=await DioRequest.patch(AppUrl.user,data: data ,createResponseModel: UserModel.createResponseModel);
    return response;
  }
}