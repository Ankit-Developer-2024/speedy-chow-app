import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/cart/domain/enitites/cart.dart';
import 'package:speedy_chow/features/payment_method/domain/enitites/create_order.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/add_address_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/create_order_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/fetch_cart_items_use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/update_address_usecase.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {

  UserModel? userModel;
  Address? addressModel;
  String paymentMethod="";
  int totalPrice=0;

  final UpdateAddressUseCase updateAddressUseCase;
  final AddAddressUseCase addAddressUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final FetchCartItemsUseCase fetchCartItemsUseCase;

  PaymentMethodBloc({
    required this.updateAddressUseCase,
    required this.addAddressUseCase,
    required this.createOrderUseCase,
    required this.fetchCartItemsUseCase
  }) : super(PaymentMethodInitial()) {
    on<AddAddressPaymentMethodEvent>(_addAddress);
    on<UpdateAddressPaymentMethodEvent>(_updateAddress);
    on<DefaultAddressEvent>(_isDefaultAddress);
    on<SelectDeliveryAddressEvent>(_selectAddress);
    on<IsPaymentMethodErrorVisibleEvent>(_isPaymentMethodErrorVisible);
    on<SelectPaymentMethodEvent>(_selectPaymentMethod);
    on<CreateOrderEvent>(_createOrder);
    on<FetchCartEvent>(_fetchCart);
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

  void _isPaymentMethodErrorVisible(IsPaymentMethodErrorVisibleEvent event,Emitter<PaymentMethodState> emit){
    emit(IsPaymentMethodErrorVisibleState(isErrorVisible: event.isErrorVisible));
  }

  void _selectPaymentMethod(SelectPaymentMethodEvent event,Emitter<PaymentMethodState> emit){
    paymentMethod=event.paymentMethod;
    emit(SelectPaymentMethodState());
  }

  void _fetchCart(FetchCartEvent event, Emitter<PaymentMethodState> emit) async{
    try {
      emit(FetchCartState(
          msg: "",
          loading: true,
          success: false,
          totalPrice: 0,
          data: []));
      ApiResponse? response=await fetchCartItemsUseCase(NoParams());

      if(response?.success==true){
        totalPrice= calTotalPrice(response?.data);
        emit(FetchCartState(
            msg: response?.message ?? "Cart fetched ",
            loading: false,
            success: true,
            totalPrice: totalPrice,
            data: response?.data ?? []
        ));
      }else{
        emit(FetchCartState(
            msg: response?.message ?? "",
            loading: false,
            success: false,
            totalPrice: 0,
            data: response?.data ?? [] ));
      }
    } catch (e) {
      emit(FetchCartState(
          msg: e.toString(),
          loading: false,
          success: false,
          totalPrice: 0,
          data:  []));
    }
  }




  void _createOrder(CreateOrderEvent event,Emitter<PaymentMethodState> emit)async{
    try{
      emit(CreateOrderState(msg: "", loading: true, success: false, createOrder: CreateOrder(isOrderCreated: false)));

      ApiResponse? response = await createOrderUseCase(
          CreateOrderUseCaseParams(
          user: event.user,
          items: event.items,
          totalAmount: event.totalAmount,
          totalItems: event.totalItems,
          paymentMethod: event.paymentMethod,
          selectedAddress: event.selectedAddress));

      if(response?.success==true){
        emit(CreateOrderState(msg: response?.message.toString() ?? "Order created successfully.", loading: false, success: true, createOrder: response?.data));
      }else{
        emit(CreateOrderState(msg: response?.message.toString() ?? "Order not created.", loading: false, success: false, createOrder: CreateOrder(isOrderCreated: false)));
      }
    }catch(e){
      emit(CreateOrderState(msg: "", loading: false, success: false, createOrder: CreateOrder(isOrderCreated: false)));
    }
  }
}
