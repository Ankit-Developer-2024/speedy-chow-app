import 'dart:io';

import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/profile/domain/repositories/update_user_image_repo.dart';

class UpdateUserImageUseCase implements UseCase<ApiResponse,UpdateUserImageParams>{
  final UpdateUserImageRepo updateUserImageRepo;

  UpdateUserImageUseCase({required this.updateUserImageRepo});
  @override
  Future<ApiResponse?> call(UpdateUserImageParams params) async{
     return await updateUserImageRepo.updateImage(image: params.image);
  }

}

class UpdateUserImageParams{
  final File image;

  UpdateUserImageParams({required this.image});

}