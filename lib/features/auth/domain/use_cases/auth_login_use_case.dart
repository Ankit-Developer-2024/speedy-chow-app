import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/auth_login_repo.dart';

class AuthLoginUseCase implements UseCase<ApiResponse,AuthLoginParam>{
  final AuthLoginRepo authLoginRepo;

  AuthLoginUseCase({required this.authLoginRepo});
  @override
  Future<ApiResponse?> call(AuthLoginParam params) async{
     return await authLoginRepo.login(data:{"email": params.email, "password": params.password});
  }
}

class AuthLoginParam{
    final String email;
    final String password;

  AuthLoginParam({required this.email, required this.password});
}