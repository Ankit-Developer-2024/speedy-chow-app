import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/reset_password_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/reset_password_repo.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepo{
  final ResetPasswordRemoteSource resetPasswordRemoteSource;

  ResetPasswordRepoImpl({required this.resetPasswordRemoteSource});

  @override
  Future<ApiResponse?> resetPassword({required Map<String, dynamic> data}) async{
    return await resetPasswordRemoteSource.resetPassword(data: data);
  }

}