import 'package:speedy_chow/features/payment_method/domain/enitites/razorpay_save_verify.dart';

class RazorpaySaveVerifyModel extends RazorpaySaveVerify{
  RazorpaySaveVerifyModel({required super.verify});

  factory RazorpaySaveVerifyModel.fromJson(Map<String,dynamic> json){
    return RazorpaySaveVerifyModel(verify: json['verify']??false);
  }

  static RazorpaySaveVerifyModel createResponseModel(Map<String,dynamic> json){
    return RazorpaySaveVerifyModel.fromJson(json);
  }
}