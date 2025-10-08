import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/auth/data/data_source/verify_otp_remote_source.dart';
import 'package:speedy_chow/features/auth/domain/repositories/verify_otp_repo.dart';

class VerifyOtpRepoImpl implements VerifyOtpRepo{
  final VerifyOtpRemoteSource verifyOtpRemoteSource;

  VerifyOtpRepoImpl({required this.verifyOtpRemoteSource});
  @override
  Future<ApiResponse?> verifyOtp({required Map<String, dynamic> data}) async{
    return await verifyOtpRemoteSource.verifyOtp(data: data);
  }

}