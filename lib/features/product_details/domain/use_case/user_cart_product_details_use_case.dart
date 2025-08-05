
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/product_detail_repository.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/user_cart_product_details_repo.dart';

class UserCartProductDetailsUseCase implements UseCase<ApiResponse,UserCartProductDetailParam>{
  final UserCartProductDetailsRepo userCartProductDetailsRepo;

  UserCartProductDetailsUseCase({required this.userCartProductDetailsRepo});
  @override
  Future<ApiResponse?> call(UserCartProductDetailParam params) async{
    return await userCartProductDetailsRepo.fetchUserCartProduct(productId:params.productId);
  }

}

class UserCartProductDetailParam{
  final String productId;
  UserCartProductDetailParam({required this.productId});
}