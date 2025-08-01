import 'package:speedy_chow/features/splash/domain/entities/verify_token.dart';

class VerifyTokenModel extends VerifyToken{

  VerifyTokenModel({required super.isVerify});

  factory VerifyTokenModel.fromJson(Map<String,dynamic> json){
    return VerifyTokenModel(isVerify: json['isVerify']??false);
  }

  static VerifyTokenModel createResponseModel(Map<String,dynamic> json){
    return VerifyTokenModel.fromJson(json);
  }

}