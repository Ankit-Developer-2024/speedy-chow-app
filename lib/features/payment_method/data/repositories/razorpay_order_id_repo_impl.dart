import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/razorpay_order_id_remote_source.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/razorpay_order_id_repo.dart';

class RazorpayOrderIdRepoImpl implements RazorpayOrderIdRepo{

  final RazorpayOrderIdRemoteSource razorpayOrderIdRemoteSource;

  RazorpayOrderIdRepoImpl({required this.razorpayOrderIdRemoteSource});

  @override
  Future<ApiResponse?> razorpayOrderId({required Map<String, dynamic> data}) async{
      return await razorpayOrderIdRemoteSource.razorpayOrderId(data: data);
  }

}