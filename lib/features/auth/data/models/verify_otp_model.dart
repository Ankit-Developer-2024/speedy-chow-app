import 'package:speedy_chow/features/auth/domain/enitites/verify_otp.dart';

class VerifyOtpModel extends VerifyOtp{
  VerifyOtpModel({required super.verify});

  factory VerifyOtpModel.fromJson(Map<String,dynamic> json){
    return VerifyOtpModel(verify: json['verify'] ?? false);
  }

  static VerifyOtpModel createResponseModel(Map<String,dynamic> json){
    return VerifyOtpModel.fromJson(json);
  }

}