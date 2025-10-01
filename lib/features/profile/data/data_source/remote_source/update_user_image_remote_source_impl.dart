import 'dart:io';

import 'package:dio/dio.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/core/services/networking/dio/dio_request.dart';
import 'package:speedy_chow/core/util/constant/app_url.dart';
import 'package:speedy_chow/features/profile/data/data_source/remote_source/update_user_image_remote_source.dart';

class UpdateUserImageRemoteSourceImpl implements UpdateUserImageRemoteSource{
  @override
  Future<ApiResponse?> updateImage({required File image}) async{
    FormData formData = FormData.fromMap({
    'image':await MultipartFile.fromFile(image.path,filename: image.path.split('/').last,)
    });

    return await DioRequest.patchWithFormData(AppUrl.userImage,data: formData ,createResponseModel: UserModel.createResponseModel);
  }

}