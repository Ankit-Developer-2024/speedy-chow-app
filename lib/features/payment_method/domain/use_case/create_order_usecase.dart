import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/create_order_repo.dart';

class CreateOrderUseCase implements UseCase<ApiResponse,CreateOrderUseCaseParams>{

  final CreateOrderRepo createOrderRepo;

  CreateOrderUseCase({required this.createOrderRepo});

  @override
  Future<ApiResponse?> call(CreateOrderUseCaseParams params) async{
     return await createOrderRepo.createOrder(data: params.toJson());
  }

}

class CreateOrderUseCaseParams{
  final String user;
  final List<Map<String,dynamic>> items;
  final int totalAmount;
  final int totalItems;
  final String paymentMethod;
  final Map<String,dynamic> selectedAddress;

  CreateOrderUseCaseParams({required this.user, required this.items, required this.totalAmount, required this.totalItems, required this.paymentMethod, required this.selectedAddress});

   Map<String,dynamic> toJson(){
    return {
      "items":items,
      "totalAmount":totalAmount,
      "totalItems":totalItems,
      "user":user,
      "paymentMethod":paymentMethod,
      "selectedAddress":selectedAddress,
    };
  }
}


