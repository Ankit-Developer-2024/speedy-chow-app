import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/update_cart_quantity_remote_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/update_cart_quantity_repo.dart';

class UpdateCartQuantityRepoImpl implements UpdateCartQuantityRepo{
  final UpdateCartQuantityRemoteSource updateCartQuantityRemoteSource;
  UpdateCartQuantityRepoImpl({required this.updateCartQuantityRemoteSource});
  @override
  Future<ApiResponse?> updateCartQuantity({required String cartId,required Map<String,dynamic> data}) async{
    return await updateCartQuantityRemoteSource.updateCartQuantity(cartId: cartId, data: data);
  }
}