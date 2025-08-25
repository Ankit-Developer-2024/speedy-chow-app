 import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/repostories/update_address_repo.dart';

class UpdateAddressUseCase implements UseCase<ApiResponse,UpdateAddressParams>{
  final UpdateAddressRepo updateAddressRepo;

  UpdateAddressUseCase({required this.updateAddressRepo});

  @override
  Future<ApiResponse?> call(UpdateAddressParams params) async{
    return await updateAddressRepo.updateAddress(id: params.id, data: params.data);
  }

}


class UpdateAddressParams{
  final String id;
  final Map<String, dynamic> data;

  UpdateAddressParams({required this.id, required this.data});
}