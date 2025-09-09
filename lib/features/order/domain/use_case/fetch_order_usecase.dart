import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/order/domain/repositories/fetch_order_repo.dart';

class FetchOrderUseCase implements UseCase<ApiResponse,NoParams>{

  final FetchOrderRepo fetchOrderRepo;

  FetchOrderUseCase({required this.fetchOrderRepo});

  @override
  Future<ApiResponse?> call(NoParams params) async{
     return await fetchOrderRepo.fetchOrder();
  }
}