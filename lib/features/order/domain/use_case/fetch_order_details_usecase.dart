import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/order/domain/repositories/fetch_order_details_repo.dart';

class FetchOrderDetailsUseCase implements UseCase<ApiResponse,FetchOrderDetailsParams>{
  final FetchOrderDetailsRepo fetchOrderDetailsRepo;

  FetchOrderDetailsUseCase({required this.fetchOrderDetailsRepo});
  @override
  Future<ApiResponse?> call(FetchOrderDetailsParams params) async{
     return await fetchOrderDetailsRepo.fetchOrderDetails(orderId: params.id);
  }

}


class FetchOrderDetailsParams{
  final String id;

  FetchOrderDetailsParams({required this.id});
}