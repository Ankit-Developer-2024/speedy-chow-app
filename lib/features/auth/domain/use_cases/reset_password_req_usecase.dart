import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/reaet_password_req_repo.dart';

class ResetPasswordReqUseCase implements UseCase<ApiResponse,ResetPasswordReqUseCaseParams>{
  final ResetPasswordReqRepo resetPasswordReqRepo;

  ResetPasswordReqUseCase({required this.resetPasswordReqRepo});

  @override
  Future<ApiResponse?> call(ResetPasswordReqUseCaseParams params) async{
    return await resetPasswordReqRepo.resetPasswordReq(data: params.toJson());
  }


}

class ResetPasswordReqUseCaseParams{
  final String email;

  ResetPasswordReqUseCaseParams({required this.email});

  Map<String,dynamic> toJson(){
    return {
      'email':email,
    };
  }

}