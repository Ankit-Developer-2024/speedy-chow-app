
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/features/auth/data/data_source/update_address_remote_source.dart';
import 'package:speedy_chow/features/profile/data/data_source/remote_source/update_user_remote_source.dart';

class UpdateAddressRemoteSourceImpl implements UpdateAddressRemoteSource{
  @override
  Future<ApiResponse?> updateAddress({required String id,required Map<String, dynamic> data}) async{
     ApiResponse? response=await DioRequest.patch("${AppUrl.updateAddress}/$id",data: data ,createResponseModel: UserModel.createResponseModel);
     return response;
  }
}