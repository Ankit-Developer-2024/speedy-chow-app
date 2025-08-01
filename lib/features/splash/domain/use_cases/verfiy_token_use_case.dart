import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/splash/domain/repositories/verify_token_repo.dart';

class VerifyTokenUseCase implements UseCase<ApiResponse,NoParams>{
  final VerifyTokenRepo verifyTokenRepo;

  VerifyTokenUseCase({required this.verifyTokenRepo});
  @override
  Future<ApiResponse?> call(NoParams params) async{
     return await verifyTokenRepo.verifyToken();
  }

}