import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UpdateUserRemoteSource{
  Future<ApiResponse?> updateUser({required Map<String,dynamic> data});
}