import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/fetch_orders_remote_source.dart';
import 'package:speedy_chow/features/order/domain/repositories/fetch_order_repo.dart';

class FetchOrderRepoImpl implements FetchOrderRepo{

  final FetchOrderRemoteSource fetchOrderRemoteSource;

  FetchOrderRepoImpl({required this.fetchOrderRemoteSource});

  @override
  Future<ApiResponse?> fetchOrder() async{
    return await fetchOrderRemoteSource.fetchOrders();
  }

}