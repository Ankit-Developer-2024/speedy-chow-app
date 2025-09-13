import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/add_address_repo.dart';

class AddAddressAuthUseCase implements UseCase<ApiResponse,AddAddressAuthParams>{
  final AddAddressRepo addAddressRepo;

  AddAddressAuthUseCase({required this.addAddressRepo});

  @override
  Future<ApiResponse?> call(AddAddressAuthParams params) async{
    return await addAddressRepo.addAddress(data: params.data);
  }

}


class AddAddressAuthParams{
  final Map<String, dynamic> data;

  AddAddressAuthParams({required this.data});
}