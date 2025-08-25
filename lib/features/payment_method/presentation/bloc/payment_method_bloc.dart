import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/add_address_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/update_address_usecase.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {

  UserModel? userModel;
  Address? addressModel;

  final UpdateAddressUseCase updateAddressUseCase;
  final AddAddressUseCase addAddressUseCase;

  PaymentMethodBloc({required this.updateAddressUseCase,required this.addAddressUseCase}) : super(PaymentMethodInitial()) {
    on<AddAddressPaymentMethodEvent>(_addAddress);
    on<UpdateAddressPaymentMethodEvent>(_updateAddress);
    on<DefaultAddressEvent>(_isDefaultAddress);
    on<SelectDeliveryAddressEvent>(_selectAddress);
  }

  void _addAddress(AddAddressPaymentMethodEvent event , Emitter<PaymentMethodState> emit)async{
    try{
      emit(AddressPaymentMethodState(msg: "", loading: true, success: false, user: event.user));

      ApiResponse? response=await addAddressUseCase(AddAddressParams(data: event.data));
      if(response?.success==true){
        userModel=response?.data;
        List<Address> address=userModel!.addresses!.where((item)=>item.isDefault==true).toList();
        addressModel=address[0];
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address added successfully", loading: false, success: true,user: response?.data));
      }else{
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address not added successfully", loading: false, success: false,user: event.user));
      }
    }catch(e){
      emit(AddressPaymentMethodState(msg: e.toString(), loading: false, success: false,user: event.user));
    }

  }

  void _updateAddress(UpdateAddressPaymentMethodEvent event , Emitter<PaymentMethodState> emit)async{
    try{
      emit(AddressPaymentMethodState(msg: "", loading: true, success: false, user: event.user));
      ApiResponse? response=await updateAddressUseCase(UpdateAddressParams(id:event.id,data: event.data));
      if(response?.success==true){
        userModel=response?.data;
        List<Address> address=userModel!.addresses!.where((item)=>item.isDefault==true).toList();
        addressModel=address[0];
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address Updated successfully", loading: false, success: true,user: response?.data));
      }else{
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address not Updated successfully", loading: false, success: false,user: event.user));
      }
    }catch(e){
      emit(AddressPaymentMethodState(msg: e.toString(), loading: false, success: false,user: event.user));
    }

  }

  void _isDefaultAddress(DefaultAddressEvent event,Emitter<PaymentMethodState> emit){
    emit(DefaultAddressState());
  }
  void _selectAddress(SelectDeliveryAddressEvent event,Emitter<PaymentMethodState> emit){
    addressModel=event.address;
    emit(SelectDeliveryAddressState());
  }
}
