import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/profile/data/data_source/remote_source/update_user_remote_source.dart';
import 'package:speedy_chow/features/profile/domain/repositories/update_user_repo.dart';

class UpdateUserRepoImpl implements UpdateUserRepo{
  final UpdateUserRemoteSource userRemoteSource;

  UpdateUserRepoImpl({required this.userRemoteSource});

  @override
  Future<ApiResponse?> updateUser({required Map<String, dynamic> data}) async{
     return await userRemoteSource.updateUser(data: data);
  }
}