import 'dart:io';

import 'package:speedy_chow/core/components/models/api_response.dart';

abstract interface class UpdateUserImageRepo{
  Future<ApiResponse?> updateImage({required File image});
}