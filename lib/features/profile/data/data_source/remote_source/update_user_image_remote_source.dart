import 'dart:io';

import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UpdateUserImageRemoteSource{
  Future<ApiResponse?> updateImage({required File image});
}