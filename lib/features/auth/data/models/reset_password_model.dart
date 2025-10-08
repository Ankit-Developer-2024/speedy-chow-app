import 'package:speedy_chow/features/auth/domain/enitites/reset_password.dart';

class ResetPasswordModel extends ResetPassword{
  ResetPasswordModel({required super.success});

  factory ResetPasswordModel.fromJson(Map<String,dynamic> json){
    return ResetPasswordModel(success: json['success']?? false);
  }

  static ResetPasswordModel createResponseModel(Map<String,dynamic> json){
    return ResetPasswordModel.fromJson(json);
  }

}