import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/auth/domain/repositories/update_address_repo.dart';

class UpdateAddressAuthUseCase implements UseCase<ApiResponse,UpdateAddressAuthParams>{
  final UpdateAddressRepo updateAddressRepo;

  UpdateAddressAuthUseCase({required this.updateAddressRepo});

  @override
  Future<ApiResponse?> call(UpdateAddressAuthParams params) async{
    return await updateAddressRepo.updateAddress(id: params.id, data: params.data);
  }

}


class UpdateAddressAuthParams{
  final String id;
  final Map<String, dynamic> data;

  UpdateAddressAuthParams({required this.id, required this.data});
}