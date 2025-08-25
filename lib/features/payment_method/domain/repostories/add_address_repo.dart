import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class AddAddressRepo{
  Future<ApiResponse?> addAddress({required Map<String,dynamic> data});
}