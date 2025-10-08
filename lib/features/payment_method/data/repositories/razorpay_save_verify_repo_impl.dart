import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/razorpay_save_verify_remote_source.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_save_verify_repo.dart';

class RazorpaySaveVerifyRepoImpl implements RazorpaySaveVerifyRepo{
  final RazorpaySaveVerifyRemoteSource razorpaySaveVerifyRemoteSource;

  RazorpaySaveVerifyRepoImpl({required this.razorpaySaveVerifyRemoteSource});
  @override
  Future<ApiResponse?> razorpaySaveVerify({required Map<String, dynamic> data}) async{
    return razorpaySaveVerifyRemoteSource.razorpaySaveVerify(data: data);
  }

}