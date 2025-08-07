import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/update_cart_quantity_repo.dart';

class UpdateCartQuantityUseCase implements UseCase<ApiResponse,UpdateCartQuantityParam>{
  final UpdateCartQuantityRepo updateCartQuantityRepo;

  UpdateCartQuantityUseCase({required this.updateCartQuantityRepo});

  @override
  Future<ApiResponse?> call(UpdateCartQuantityParam params) async{
    return await updateCartQuantityRepo.updateCartQuantity(cartId: params.cartId, data: params.data);
  }

}

class UpdateCartQuantityParam{
  final String cartId;
  final Map<String,dynamic> data;

  UpdateCartQuantityParam({required this.cartId, required this.data});
}