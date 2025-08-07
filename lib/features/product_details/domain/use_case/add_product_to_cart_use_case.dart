import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/add_product_to_cart_repo.dart';
import 'package:speedy_chow/features/product_details/domain/repositories/update_cart_quantity_repo.dart';

class AddProductToCartUseCase implements UseCase<ApiResponse,AddProductToCartParam>{
  final AddProductToCartRepo addProductToCartRepo;

  AddProductToCartUseCase({required this.addProductToCartRepo});

  @override
  Future<ApiResponse?> call(AddProductToCartParam params) async{
    return await addProductToCartRepo.addToCart(data: params.data);
  }

}

class AddProductToCartParam{
  final Map<String,dynamic> data;

  AddProductToCartParam({required this.data});
}