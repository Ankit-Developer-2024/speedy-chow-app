import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/order/data/data_source/remote_source/update_order_remote_source.dart';
import 'package:speedy_chow/features/order/domain/repositories/update_order_repo.dart';

class UpdateOrderRepoImpl implements UpdateOrderRepo{

  UpdateOrderRemoteSource updateOrderRemoteSource;

  UpdateOrderRepoImpl({required this.updateOrderRemoteSource});

  @override
  Future<ApiResponse?> updateOrder({required String id ,required Map<String,dynamic> data}) async{
   return await updateOrderRemoteSource.updateOrder(id: id, data: data);
  }

}