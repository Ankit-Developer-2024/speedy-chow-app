import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/cart/data/data_source/remote_source/delete_cart_remote_source.dart';
import 'package:speedy_chow/features/cart/domain/repositories/delete_cart_repo.dart';

class DeleteCartRepoImpl implements DeleteCartRepo{
  final DeleteCartRemoteSource deleteCartRemoteSource;

  DeleteCartRepoImpl({required this.deleteCartRemoteSource});
  @override
  Future<ApiResponse?> deleteCart({required String cartId}) async{
   return await deleteCartRemoteSource.deleteCart(cartId: cartId);
  }
}