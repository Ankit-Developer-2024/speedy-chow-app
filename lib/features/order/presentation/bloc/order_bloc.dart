import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';
import 'package:speedy_chow/features/order/domain/use_case/create_order_buy_again_usecase.dart';
import 'package:speedy_chow/features/order/domain/use_case/fetch_order_details_usecase.dart';
import 'package:speedy_chow/features/order/domain/use_case/fetch_order_usecase.dart';
import 'package:speedy_chow/features/order/domain/use_case/update_order_usecase.dart';
import 'package:speedy_chow/features/payment_method/domain/enitites/create_order.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  AddressModel? selectedAddress;
  String paymentMethod="";

  final FetchOrderUseCase fetchOrderUseCase;
  final FetchOrderDetailsUseCase fetchOrderDetailsUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  final CreateOrderBuyAgainUseCase createOrderBuyAgainUseCase;

  OrderBloc({
    required this.fetchOrderUseCase,
    required this.fetchOrderDetailsUseCase,
    required this.updateOrderUseCase,
    required this.createOrderBuyAgainUseCase
    }) : super(OrderInitial()) {
    on<FetchOrderEvent>(_fetchOrder);
    on<FetchOrderDetailsEvent>(_fetchOrderDetails);
    on<UpdateOrderEvent>(_updateOrder);
    on<SelectedAddressEvent>(_selectAddress);
    on<SelectPaymentMethodEvent>(_selectPaymentMethod);
    on<IsPaymentMethodErrorVisibleEvent>(_isPaymentMethodErrorVisible);
    on<CreateOrderEvent>(_createOrder);
  }

  void _fetchOrder(OrderEvent event , Emitter<OrderState> emit)async{
    try{
      emit(FetchOrderState(loading: true, success: false, message: "", orders: []));
      ApiResponse? response = await fetchOrderUseCase(NoParams());
      if(response?.success==true){
        emit(FetchOrderState(loading: false, success: true, message: response?.message.toString() ?? "Order fetch successfully", orders: ((response?.data as List).reversed.toList() as List<Order>)));
      }else{
        emit(FetchOrderState(loading: false, success: false, message: response?.message.toString() ?? "Order not fetch successfully", orders: []));
      }
    }catch(e,stack){
      emit(FetchOrderState(loading: false, success: false, message: e.toString(), orders: []));
    }
  }


   void _fetchOrderDetails(FetchOrderDetailsEvent event , Emitter<OrderState> emit)async{
    try{
      emit(FetchOrderDetailsState(loading: true, success: false, message: "", order: null));
      ApiResponse? response = await fetchOrderDetailsUseCase(FetchOrderDetailsParams(id: event.id));
      if(response?.success==true){
        emit(FetchOrderDetailsState(loading: false, success: true, message: response?.message.toString() ?? "Order details fetch successfully", order:response?.data));
      }else{
        emit(FetchOrderDetailsState(loading: false, success: false, message: response?.message.toString() ?? "Order details not fetch successfully", order: null));
      }
    }catch(e,stack){
      emit(FetchOrderDetailsState(loading: false, success: false, message: e.toString(), order: null));
    }
  }


  void _updateOrder(UpdateOrderEvent event , Emitter<OrderState> emit)async{
    try{
      emit(UpdateOrderState(loading: true, success: false, message: "", order: null));
      ApiResponse? response = await updateOrderUseCase(UpdateOrderParams(id: event.id, data: event.data));
      if(response?.success==true){
        emit(UpdateOrderState(loading: false, success: true, message: response?.message.toString() ?? "Order update successfully!", order:response?.data));
      }else{
        emit(UpdateOrderState(loading: false, success: false, message: response?.message.toString() ?? "Order not update successfully!", order: null));
      }
    }catch(e,stack){
      emit(UpdateOrderState(loading: false, success: false, message: e.toString(), order: null));
    }
  }

  void _selectAddress(SelectedAddressEvent event , Emitter<OrderState> emit)async{
      emit(SelectedAddressState());
  }

  void _selectPaymentMethod(SelectPaymentMethodEvent event ,  Emitter<OrderState> emit)async{
    emit(SelectPaymentMethodState());
  }

  void _isPaymentMethodErrorVisible(IsPaymentMethodErrorVisibleEvent event ,  Emitter<OrderState> emit)async{
    emit(IsPaymentMethodErrorVisibleState(isErrorVisible: event.isErrorVisible));
  }

  void _createOrder(CreateOrderEvent event,Emitter<OrderState> emit)async{
    try{
      emit(CreateOrderState(msg: "", loading: true, success: false, createOrder: CreateOrder(isOrderCreated: false)));

      ApiResponse? response = await createOrderBuyAgainUseCase(
          CreateOrderBuyAgainUseCaseParams(
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


  String getOrderStatus(OrderStatus status){
    switch(status){
      case OrderStatus.orderedConfirmed:
        return "Order Confirmed";
      case OrderStatus.preparingFood:
        return "Preparing Food";
      case OrderStatus.outForDelivery:
        return "Out For Delivery";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
      }
  }

  Color getOrderStatusColor(OrderStatus status){
    switch(status){
      case OrderStatus.orderedConfirmed:
       return AppColors.primaryGreen;
      case OrderStatus.preparingFood:
        return AppColors.darkOrange;
      case OrderStatus.outForDelivery:
        return AppColors.darkOrange;
      case OrderStatus.delivered:
        return AppColors.primaryGreen;
      case OrderStatus.cancelled:
        return AppColors.errorRed;
      }
  }

}
