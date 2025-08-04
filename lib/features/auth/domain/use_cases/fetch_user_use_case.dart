import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/user_repo.dart';

class FetchUserUseCase implements UseCase<ApiResponse,NoParams>{
  final UserRepo userRepo;

  FetchUserUseCase({required this.userRepo});
  @override
  Future<ApiResponse?> call(NoParams params) async{
    return await userRepo.fetchUser();
  }
}

