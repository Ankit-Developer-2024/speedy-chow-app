import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/core/services/connectivity/connectivity.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/data/models/cart_model.dart';
import 'package:speedy_chow/features/payment_method/domain/enitites/create_order.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/add_address_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/create_order_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/fetch_cart_items_use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/razorpay_order_id_use_case.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/razorpay_save_verify_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/use_case/update_address_usecase.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {

  UserModel? userModel;
  AddressModel? selectedAddressModel;
  String paymentMethod="";
  List<CartModel> items=[];
  int totalPrice=0;

  final UpdateAddressUseCase updateAddressUseCase;
  final AddAddressUseCase addAddressUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final FetchCartItemsUseCase fetchCartItemsUseCase;
  final RazorpayOrderIdUseCase razorpayOrderIdUseCase;
  final Razorpay razorpay;
  final RazorpaySaveVerifyUseCase razorpaySaveVerifyUseCase;

  PaymentMethodBloc({
    required this.updateAddressUseCase,
    required this.addAddressUseCase,
    required this.createOrderUseCase,
    required this.fetchCartItemsUseCase,
    required this.razorpay,
    required this.razorpayOrderIdUseCase,
    required this.razorpaySaveVerifyUseCase,
  }) : super(PaymentMethodInitial()) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    on<AddAddressPaymentMethodEvent>(_addAddress);
    on<UpdateAddressPaymentMethodEvent>(_updateAddress);
    on<DefaultAddressEvent>(_isDefaultAddress);
    on<SelectDeliveryAddressEvent>(_selectAddress);
    on<IsPaymentMethodErrorVisibleEvent>(_isPaymentMethodErrorVisible);
    on<SelectPaymentMethodEvent>(_selectPaymentMethod);
    on<CreateOrderEvent>(_createOrder);
    on<FetchCartEvent>(_fetchCart);
    on<RazorpayPaymentEvent>(_razorpayPayment);
    on<RazorpayPaymentNotifyErrorEvent>(_razorpayPaymentNotifyError);
  }

  void _addAddress(AddAddressPaymentMethodEvent event , Emitter<PaymentMethodState> emit)async{
    try{
      emit(AddressPaymentMethodState(msg: "", loading: true, success: false, user: event.user));
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await addAddressUseCase(AddAddressParams(data: event.data));
      if(response?.success==true){
        userModel=response?.data;
        List<AddressModel> address=userModel!.addresses!.where((item)=>item.isDefault==true).toList();
        selectedAddressModel=address[0];
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address added successfully", loading: false, success: true,user: response?.data));
      }else{
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address not added successfully", loading: false, success: false,user: event.user));
      }}else{
        emit(AddressPaymentMethodState(msg:"No internet!", loading: false, success: false,user: event.user));
      }
    }catch(e){
      emit(AddressPaymentMethodState(msg: e.toString(), loading: false, success: false,user: event.user));
    }

  }

  void _updateAddress(UpdateAddressPaymentMethodEvent event , Emitter<PaymentMethodState> emit)async{
    try{
      emit(AddressPaymentMethodState(msg: "", loading: true, success: false, user: event.user));
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await updateAddressUseCase(UpdateAddressParams(id:event.id,data: event.data));
      if(response?.success==true){
        userModel=response?.data;
        List<AddressModel> address=userModel!.addresses!.where((item)=>item.isDefault==true).toList();
        selectedAddressModel=address[0];
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address Updated successfully", loading: false, success: true,user: response?.data));
      }else{
        emit(AddressPaymentMethodState(msg: response?.message.toString() ?? "Address not Updated successfully", loading: false, success: false,user: event.user));
      }}else{
        emit(AddressPaymentMethodState(msg: "No internet!", loading: false, success: false,user: event.user));
      }
    }catch(e){
      emit(AddressPaymentMethodState(msg: e.toString(), loading: false, success: false,user: event.user));
    }

  }

  void _isDefaultAddress(DefaultAddressEvent event,Emitter<PaymentMethodState> emit){
    emit(DefaultAddressState());
  }

  void _selectAddress(SelectDeliveryAddressEvent event,Emitter<PaymentMethodState> emit){
    selectedAddressModel=event.address;
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
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await fetchCartItemsUseCase(NoParams());

      if(response?.success==true){
        totalPrice= calTotalPrice(response?.data);
        items=response?.data ?? [];
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
      }}else{
        emit(FetchCartState(
            msg: "No internet!",
            loading: false,
            success: false,
            totalPrice: 0,
            data: [] ));
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
      if( await CheckConnectivity.checkConnectivity()){
      ApiResponse? response = await createOrderUseCase(
          CreateOrderUseCaseParams(
          items: event.items,
          totalAmount: event.totalAmount,
          totalItems: event.totalItems,
          paymentMethod: event.paymentMethod,
          selectedAddress: event.selectedAddress,
          paymentId: event.paymentId
          ));

      if(response?.success==true){
        emit(CreateOrderState(msg: response?.message.toString() ?? "Order created successfully.", loading: false, success: true, createOrder: response?.data));
      }else{
        emit(CreateOrderState(msg: response?.message.toString() ?? "Order not created.", loading: false, success: false, createOrder: CreateOrder(isOrderCreated: false)));
     }}else{
        emit(CreateOrderState(msg: "No internet!", loading: false, success: false, createOrder: CreateOrder(isOrderCreated: false)));
      }
    }catch(e){
      emit(CreateOrderState(msg: "", loading: false, success: false, createOrder: CreateOrder(isOrderCreated: false)));
    }
  }

  void _razorpayPayment(RazorpayPaymentEvent event,Emitter<PaymentMethodState> emit)async{
      try{
        if(await CheckConnectivity.checkConnectivity()){
        ApiResponse? response = await razorpayOrderIdUseCase(RazorpayOrderIdParams(amount: totalPrice*100, otherDetails: {"totalItems":items.length}));
        if(response?.success==true){
          var options = {
            'key': 'rzp_test_ROzfZsP410mNpn',
            'amount': response?.data.amount,
            'name': 'Speedy Chow',
            'description': 'Buy fast food from Speedy Chow',
            "order_id": response?.data.orderId,
            'retry': {'enabled': true, 'max_count': 4},
            'send_sms_hash': true,
            'prefill': {'contact': '+918059600000', 'email': 'test@razorpay.com'},
          };
            razorpay.open(options);
        }else{
          emit(RazorpayPaymentNotifyErrorState(msg: response?.message ?? "Payment failed!"));
        }}else{
          emit(RazorpayPaymentNotifyErrorState(msg:"No internet!"));
        }

      }catch (err){
        emit(RazorpayPaymentNotifyErrorState(msg: "$err | Payment failed!"));

      }
  }

  void _razorpayPaymentNotifyError(RazorpayPaymentNotifyErrorEvent event,Emitter<PaymentMethodState> emit){
    emit(RazorpayPaymentNotifyErrorState(msg: event.msg));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
      //call api save data and verify in single api
     try{
       if(response.paymentId!=null && response.orderId!=null && response.signature!=null){

         ApiResponse? resp=await razorpaySaveVerifyUseCase(RazorpaySaveVerifyParams(paymentId: response.paymentId!, orderId: response.orderId!, paymentSignature: response.signature!));
         if(resp?.success==true && resp?.data.verify==true){
           add(CreateOrderEvent(
               items: items
                   .map((item) => item.toJson())
                   .toList(),
               totalAmount: totalPrice,
               totalItems: items.length,
               paymentMethod: "Razorpay",
               selectedAddress: selectedAddressModel == null ? {}
                   : selectedAddressModel!.toJson(),
             paymentId: response.paymentId!
           ));
         }else{
           print("222222222222");
            add(RazorpayPaymentNotifyErrorEvent(msg: "Payment not verified"));
         }
       }
     }catch(err){
       print("3333333333333333333${err.toString()}");
       add(RazorpayPaymentNotifyErrorEvent(msg: err.toString()));
     }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    add(RazorpayPaymentNotifyErrorEvent(msg: "Payment failed"));
  }


  @override
  Future<void> close() {
    razorpay.clear();
    return super.close();
  }


}
