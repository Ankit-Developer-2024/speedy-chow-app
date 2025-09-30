import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/register_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo{
  final RegisterRemoteSource registerRemoteSource;

  RegisterRepoImpl({required this.registerRemoteSource});
  @override
  Future<ApiResponse?> register({required Map<String, dynamic> data}) async{
    return await registerRemoteSource.register(data: data);
  }
}