import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/fetch_order_details_remote_source.dart';
import 'package:speedy_chow/features/order/domain/repositories/fetch_order_details_repo.dart';

class FetchOrderDetailsRepoImpl implements FetchOrderDetailsRepo{
  final FetchOrderDetailsRemoteSource fetchOrderDetailsRemoteSource;

  FetchOrderDetailsRepoImpl({required this.fetchOrderDetailsRemoteSource});
  @override
  Future<ApiResponse?> fetchOrderDetails({required String orderId}) async{
     return await fetchOrderDetailsRemoteSource.fetchOrderDetails(orderId: orderId);
  }
}