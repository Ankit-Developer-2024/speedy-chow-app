import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/cart/domain/repositories/fetch_cart_products_repo.dart';

class FetchCartItemsUseCase implements UseCase<ApiResponse,NoParams>{
  final FetchCartProductsRepo fetchCartProductsRepo;

  FetchCartItemsUseCase({required this.fetchCartProductsRepo});
  @override
  Future<ApiResponse?> call(NoParams params) async{
     return await fetchCartProductsRepo.fetchCartProducts();
  }

}

