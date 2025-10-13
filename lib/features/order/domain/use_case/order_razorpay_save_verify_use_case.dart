import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_save_verify_repo.dart';

class OrderRazorpaySaveVerifyUseCase implements UseCase<ApiResponse,OrderRazorpaySaveVerifyParams>{

  final RazorpaySaveVerifyRepo razorpaySaveVerifyRepo;

  OrderRazorpaySaveVerifyUseCase({required this.razorpaySaveVerifyRepo});

  @override
  Future<ApiResponse?> call(OrderRazorpaySaveVerifyParams params) async{
    return await razorpaySaveVerifyRepo.razorpaySaveVerify(data: params.toJson());
  }

}


class OrderRazorpaySaveVerifyParams{
  final String paymentId;
  final String orderId;
  final String paymentSignature;

  OrderRazorpaySaveVerifyParams({required this.paymentId, required this.orderId, required this.paymentSignature});

  Map<String,dynamic> toJson(){
    return {
      'paymentId':paymentId,
      'orderId':orderId,
      'paymentSignature':paymentSignature
    };
  }

}