
import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class ProductRemoteSource{

  Future<ApiResponse?> fetchAllProduct({required List<String> filterProductByName});
}