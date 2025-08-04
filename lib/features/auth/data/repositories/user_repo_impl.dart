import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/user_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo{
  final UserRemoteSource userRemoteSource;

  UserRepoImpl({required this.userRemoteSource});
  @override
  Future<ApiResponse?> fetchUser() async{
    return await userRemoteSource.fetchUser();
  }
}