import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/create_order_remote_source.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/create_order_repo.dart';

class CreateOrderRepoImpl implements CreateOrderRepo{
  final CreateOrderRemoteSource createOrderRemoteSource;

  CreateOrderRepoImpl({required this.createOrderRemoteSource});
  @override
  Future<ApiResponse?> createOrder({required Map<String, dynamic> data}) async{
     return await createOrderRemoteSource.createOrder(data: data);
  }

}