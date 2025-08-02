import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class AuthLoginRepo{
  Future<ApiResponse?> login({required Map<String,dynamic> data});
}