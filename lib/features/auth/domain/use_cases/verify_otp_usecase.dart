import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/verify_otp_repo.dart';

class VerifyOtpUseCase implements UseCase<ApiResponse,VerifyOtpUseCaseParams>{
  final VerifyOtpRepo verifyOtpRepo;

  VerifyOtpUseCase({required this.verifyOtpRepo});

  @override
  Future<ApiResponse?> call(VerifyOtpUseCaseParams params) async{
    return await verifyOtpRepo.verifyOtp(data: params.toJson());
  }
}

class VerifyOtpUseCaseParams{
  final String otp;
  final String email;

  VerifyOtpUseCaseParams({required this.otp,required this.email});

  Map<String,dynamic> toJson(){
    return {
      'otp':otp,
      'email':email
    };
  }

}