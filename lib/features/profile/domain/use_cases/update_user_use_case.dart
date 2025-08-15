import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/profile/domain/repositories/update_user_repo.dart';

class UpdateUserUseCase implements UseCase<ApiResponse,UpdateUserParam>{
  final UpdateUserRepo userRepo;

  UpdateUserUseCase({required this.userRepo});
  @override
  Future<ApiResponse?> call(UpdateUserParam params) async{
     return await userRepo.updateUser(data: params.data);
  }

}


class UpdateUserParam{
  final Map<String,dynamic> data;

  UpdateUserParam({required this.data});

}