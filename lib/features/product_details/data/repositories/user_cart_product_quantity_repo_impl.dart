
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/product_detail_remote_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/user_cart_product_quantity_remote_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/user_cart_product_quantity_repo.dart';

class UserCartProductQuantityRepoImpl implements UserCartProductQuantityRepo{
  final UserCartProductQuantityRemoteSource userCartProductQuantityRemoteSource;

  UserCartProductQuantityRepoImpl({required this.userCartProductQuantityRemoteSource});
  @override
  Future<ApiResponse?> fetchUserCartProductQuantity({required String productId}) async{
    return await userCartProductQuantityRemoteSource.fetchUserCartProductQuantity(id: productId);
  }

}