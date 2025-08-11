import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/cart/domain/repositories/update_cart_repo.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/update_cart_quantity_repo.dart';

class UpdateCartUseCase implements UseCase<ApiResponse,UpdateCartParam>{
  final UpdateCartRepo updateCartRepo;

  UpdateCartUseCase({required this.updateCartRepo});

  @override
  Future<ApiResponse?> call(UpdateCartParam params) async{
    return await updateCartRepo.updateCartQuantity(cartId: params.cartId, data: params.data);
  }

}

class UpdateCartParam{
  final String cartId;
  final Map<String,dynamic> data;

  UpdateCartParam({required this.cartId, required this.data});
}