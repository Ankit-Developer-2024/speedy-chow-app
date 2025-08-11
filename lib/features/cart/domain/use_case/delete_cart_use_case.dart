import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/cart/domain/repositories/delete_cart_repo.dart';

class DeleteCartUseCase implements UseCase<ApiResponse,DeleteCartParam>{
  final DeleteCartRepo deleteCartRepo;

  DeleteCartUseCase({required this.deleteCartRepo});
  @override
  Future<ApiResponse?> call(DeleteCartParam params) async{
    return await deleteCartRepo.deleteCart(cartId: params.cartId);
  }

}

class DeleteCartParam{
  final String cartId;

  DeleteCartParam({required this.cartId});

}