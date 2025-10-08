import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_order_id_repo.dart';

class RazorpayOrderIdUseCase implements UseCase<ApiResponse,RazorpayOrderIdParams>{
  final RazorpayOrderIdRepo razorpayOrderIdRepo;

  RazorpayOrderIdUseCase({required this.razorpayOrderIdRepo});
  @override
  Future<ApiResponse?> call(RazorpayOrderIdParams params) async{
     return await razorpayOrderIdRepo.razorpayOrderId(data: params.toJson());
  }

}

class RazorpayOrderIdParams{
  final int amount;
  final Map<String,dynamic> otherDetails;

  RazorpayOrderIdParams({required this.amount,required this.otherDetails});

  Map<String,dynamic> toJson(){
    return {
      "amount":amount,
      "otherDetails":otherDetails,
    };
  }
}