import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/cart/data/data_source/local_source/cart_local_source.dart';
import 'package:speedy_chow/features/cart/domain/repositories/user_cart_repository.dart';

class UserCartRepositoryImpl implements UserCartRepository{
  final CartLocalSource cartLocalSource;

  UserCartRepositoryImpl({required this.cartLocalSource});
  @override
  Future<ApiResponse?> fetchUserCart(String userId) async{
    return await cartLocalSource.fetchUserCart(userId);
  }

}