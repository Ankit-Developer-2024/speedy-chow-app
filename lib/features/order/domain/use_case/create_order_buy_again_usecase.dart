import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/create_order_repo.dart';

class CreateOrderBuyAgainUseCase implements UseCase<ApiResponse,CreateOrderBuyAgainUseCaseParams>{

  final CreateOrderRepo createOrderRepo;

  CreateOrderBuyAgainUseCase({required this.createOrderRepo});

  @override
  Future<ApiResponse?> call(CreateOrderBuyAgainUseCaseParams params) async{
    return await createOrderRepo.createOrder(data: params.toJson());
  }

}

class CreateOrderBuyAgainUseCaseParams{
  final List<Map<String,dynamic>> items;
  final int totalAmount;
  final int totalItems;
  final String paymentMethod;
  final String paymentId;
  final Map<String,dynamic> selectedAddress;

  CreateOrderBuyAgainUseCaseParams({required this.paymentId,required this.items, required this.totalAmount, required this.totalItems, required this.paymentMethod, required this.selectedAddress});

  Map<String,dynamic> toJson(){
    return {
      "items":items,
      "totalAmount":totalAmount,
      "totalItems":totalItems,
      "paymentMethod":paymentMethod,
      "selectedAddress":selectedAddress,
      "paymentId":paymentId
    };
  }
}