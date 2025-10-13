import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_order_id_repo.dart';

class OrderRazorpayOrderIdUseCase implements UseCase<ApiResponse,OrderRazorpayOrderIdParams>{
  final RazorpayOrderIdRepo razorpayOrderIdRepo;

  OrderRazorpayOrderIdUseCase({required this.razorpayOrderIdRepo});
  @override
  Future<ApiResponse?> call(OrderRazorpayOrderIdParams params) async{
    return await razorpayOrderIdRepo.razorpayOrderId(data: params.toJson());
  }

}

class OrderRazorpayOrderIdParams{
  final int amount;
  final Map<String,dynamic> otherDetails;

  OrderRazorpayOrderIdParams({required this.amount,required this.otherDetails});

  Map<String,dynamic> toJson(){
    return {
      "amount":amount,
      "otherDetails":otherDetails,
    };
  }
}