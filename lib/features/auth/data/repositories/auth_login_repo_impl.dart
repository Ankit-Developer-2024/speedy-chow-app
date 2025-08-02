import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/aut_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/auth_login_repo.dart';

class AuthLoginRepoImpl implements AuthLoginRepo{
  final AuthRemoteSource authRemoteSource;

  AuthLoginRepoImpl({required this.authRemoteSource});
  @override
  Future<ApiResponse?> login({required Map<String,dynamic> data}) async{
    return await authRemoteSource.login(data: data);
  }
}