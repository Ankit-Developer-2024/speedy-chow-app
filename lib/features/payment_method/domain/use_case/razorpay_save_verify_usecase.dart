import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_save_verify_repo.dart';

class RazorpaySaveVerifyUseCase implements UseCase<ApiResponse,RazorpaySaveVerifyParams>{

  final RazorpaySaveVerifyRepo razorpaySaveVerifyRepo;

  RazorpaySaveVerifyUseCase({required this.razorpaySaveVerifyRepo});

  @override
  Future<ApiResponse?> call(RazorpaySaveVerifyParams params) async{
    return await razorpaySaveVerifyRepo.razorpaySaveVerify(data: params.toJson());
  }

}


class RazorpaySaveVerifyParams{
  final String paymentId;
  final String orderId;
  final String paymentSignature;

  RazorpaySaveVerifyParams({required this.paymentId, required this.orderId, required this.paymentSignature});

  Map<String,dynamic> toJson(){
    return {
      'paymentId':paymentId,
      'orderId':orderId,
      'paymentSignature':paymentSignature
    };
  }

}