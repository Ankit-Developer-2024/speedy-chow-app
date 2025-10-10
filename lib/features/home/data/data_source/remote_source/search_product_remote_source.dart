import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class SearchProductRemoteSource {
  Future<ApiResponse?> searchProduct({required Map<String,dynamic> data});
}