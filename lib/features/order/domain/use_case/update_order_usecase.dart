import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/order/domain/repositories/fetch_order_repo.dart';
import 'package:speedy_chow/features/order/domain/repositories/update_order_repo.dart';

class UpdateOrderUseCase implements UseCase<ApiResponse,UpdateOrderParams>{

  final UpdateOrderRepo updateOrderRepo;

  UpdateOrderUseCase({required this.updateOrderRepo});

  @override
  Future<ApiResponse?> call(UpdateOrderParams params) async{
    return await updateOrderRepo.updateOrder(id: params.id, data: params.data);
  }
}

class UpdateOrderParams{
  String id;
  Map<String,dynamic> data;

  UpdateOrderParams({required this.id , required this.data});
}