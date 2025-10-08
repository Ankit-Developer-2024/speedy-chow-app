import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/reset_password_req_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/reaet_password_req_repo.dart';

class ResetPasswordReqRepoImpl implements ResetPasswordReqRepo{
  final ResetPasswordReqRemoteSource resetPasswordReqRemoteSource;

  ResetPasswordReqRepoImpl({required this.resetPasswordReqRemoteSource});

  @override
  Future<ApiResponse?> resetPasswordReq({required Map<String, dynamic> data}) async{
   return await resetPasswordReqRemoteSource.resetPasswordReq(data: data);
  }

}