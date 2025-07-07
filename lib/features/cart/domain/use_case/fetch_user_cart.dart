import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/cart/domain/repositories/user_cart_repository.dart';

class FetchUserCart implements UseCase<ApiResponse,UserCartParam>{
  final UserCartRepository userCartRepository;

  FetchUserCart({required this.userCartRepository});
  @override
  Future<ApiResponse?> call(UserCartParam params) async{
     return await userCartRepository.fetchUserCart(params.userId);
  }

}

class UserCartParam{
  final String userId;

  UserCartParam({required this.userId});
}