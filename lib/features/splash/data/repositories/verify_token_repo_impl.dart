import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/splash/data/data_source/verify_token_remote_source.dart';
import 'package:speedy_chow/features/splash/domain/repositories/verify_token_repo.dart';

class VerifyTokenRepoImpl implements VerifyTokenRepo{
  final VerifyTokenRemoteSource verifyTokenRemoteSource;

  VerifyTokenRepoImpl({required this.verifyTokenRemoteSource});
  @override
  Future<ApiResponse?> verifyToken() async{
   return await verifyTokenRemoteSource.verifyToken();
  }
}