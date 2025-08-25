import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/update_address_remote_source.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/update_address_repo.dart';

class UpdateAddressRepoImpl implements UpdateAddressRepo{
  final UpdateAddressRemoteSource updateAddressRemoteSource;

  UpdateAddressRepoImpl({required this.updateAddressRemoteSource});
  @override
  Future<ApiResponse?> updateAddress({required String id, required Map<String, dynamic> data}) async{
    ApiResponse? response = await updateAddressRemoteSource.updateAddress(id: id, data: data);
    return response;
  }
}