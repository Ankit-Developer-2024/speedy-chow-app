import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/add_address_remote_source.dart';
import 'package:speedy_chow/features/payment_method/data/data_source/remote_source/update_address_remote_source.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/add_address_repo.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/update_address_repo.dart';

class AddAddressRepoImpl implements AddAddressRepo{
  final AddAddressRemoteSource addAddressRemoteSource;

  AddAddressRepoImpl({required this.addAddressRemoteSource});
  @override
  Future<ApiResponse?> addAddress({required Map<String, dynamic> data}) async{
    ApiResponse? response = await addAddressRemoteSource.addAddress(data: data);
    return response;
  }
}