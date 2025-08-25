import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/add_address_repo.dart';

class AddAddressUseCase implements UseCase<ApiResponse,AddAddressParams>{
  final AddAddressRepo addAddressRepo;

  AddAddressUseCase({required this.addAddressRepo});

  @override
  Future<ApiResponse?> call(AddAddressParams params) async{
    return await addAddressRepo.addAddress(data: params.data);
  }

}


class AddAddressParams{
  final Map<String, dynamic> data;

  AddAddressParams({required this.data});
}