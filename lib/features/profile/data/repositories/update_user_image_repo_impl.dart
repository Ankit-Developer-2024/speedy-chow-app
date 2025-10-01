import 'dart:io';

import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/profile/data/data_source/remote_source/update_user_image_remote_source.dart';
import 'package:speedy_chow/features/profile/domain/repositories/update_user_image_repo.dart';

class UpdateUserImageRepoImpl implements UpdateUserImageRepo{
  final UpdateUserImageRemoteSource updateUserImageRemoteSource;
  UpdateUserImageRepoImpl({required this.updateUserImageRemoteSource});
  @override
  Future<ApiResponse?> updateImage({required File image}) async{
    return await updateUserImageRemoteSource.updateImage(image: image );
  }

}