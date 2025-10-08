import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/reset_password_repo.dart';

class ResetPasswordUseCase implements UseCase<ApiResponse,ResetPasswordUseCaseParams>{
  final ResetPasswordRepo resetPasswordRepo;

  ResetPasswordUseCase({required this.resetPasswordRepo});

  @override
  Future<ApiResponse?> call(ResetPasswordUseCaseParams params) async{
    return await resetPasswordRepo.resetPassword(data: params.toJson());
  }


}

class ResetPasswordUseCaseParams{
  final String email;
  final String password;

  ResetPasswordUseCaseParams({required this.email,required this.password});

  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'password':password
    };
  }

}