import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/register_repo.dart';

class RegisterUseCase implements UseCase<ApiResponse,RegisterParam>{
  final RegisterRepo registerRepo;

  RegisterUseCase({required this.registerRepo});
  @override
  Future<ApiResponse?> call(RegisterParam params) async{
    return await registerRepo.register(data: params.data);
  }

}

class RegisterParam{
  final Map<String,dynamic> data;

  RegisterParam({required this.data});
}