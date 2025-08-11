import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/cart/data/data_source/remote_source/update_cart_remote_source.dart';
import 'package:speedy_chow/features/cart/domain/repositories/update_cart_repo.dart';

class UpdateCartRepoImpl implements UpdateCartRepo{
  final UpdateCartRemoteSource updateCartRemoteSource;
  UpdateCartRepoImpl({required this.updateCartRemoteSource});
  @override
  Future<ApiResponse?> updateCartQuantity({required String cartId,required Map<String,dynamic> data}) async{
    return await updateCartRemoteSource.updateCartQuantity(cartId: cartId, data: data);
  }
}