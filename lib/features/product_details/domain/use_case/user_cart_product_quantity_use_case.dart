
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/user_cart_product_quantity_repo.dart';

class UserCartProductQuantityUseCase implements UseCase<ApiResponse,UserCartProductQuantityParam>{
  final UserCartProductQuantityRepo userCartProductQuantityRepo;

  UserCartProductQuantityUseCase({required this.userCartProductQuantityRepo});
  @override
  Future<ApiResponse?> call(UserCartProductQuantityParam params) async{
    return await userCartProductQuantityRepo.fetchUserCartProductQuantity(productId:params.productId);
  }

}

class UserCartProductQuantityParam{
  final String productId;
  UserCartProductQuantityParam({required this.productId});
}