
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/data/data_source/local_source/product_detail_local_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/product_detail_remote_source.dart';
import 'package:speedy_chow/features/product_details/data/data_source/remote_source/user_cart_product_details_remote_source.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/user_cart_product_details_repo.dart';

class UserCartProductDetailsRepoImpl implements UserCartProductDetailsRepo{
  final UserCartProductDetailsRemoteSource userCartProductDetailsRemoteSource;

  UserCartProductDetailsRepoImpl({required this.userCartProductDetailsRemoteSource});
  @override
  Future<ApiResponse?> fetchUserCartProduct({required String productId}) async{
    return await userCartProductDetailsRemoteSource.fetchUserCartProductDetails(id: productId);
  }

}