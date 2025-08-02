import 'package:speedy_chow/features/auth/domain/enitites/auth.dart';

class AuthModels extends Auth {
  AuthModels({required super.id, required super.email, required super.role});

  factory AuthModels.fromJson(Map<String, dynamic> json) {
    return AuthModels(
        id: json['id'] ?? "",
        email: json['email'],
        role: json['role']
    );
  }

  static AuthModels createResponseModel(Map<String,dynamic> json){
    return AuthModels.fromJson(json);
  }
}
