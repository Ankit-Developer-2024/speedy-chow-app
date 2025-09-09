import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';
import 'package:speedy_chow/features/order/domain/use_case/fetch_order_details_usecase.dart';
import 'package:speedy_chow/features/order/domain/use_case/fetch_order_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  final FetchOrderUseCase fetchOrderUseCase;
  final FetchOrderDetailsUseCase fetchOrderDetailsUseCase;

  OrderBloc({
    required this.fetchOrderUseCase,
    required this.fetchOrderDetailsUseCase,
    }) : super(OrderInitial()) {
    on<FetchOrderEvent>(_fetchOrder);
    on<FetchOrderDetailsEvent>(_fetchOrderDetails);
  }

  void _fetchOrder(OrderEvent event , Emitter<OrderState> emit)async{
    try{
      emit(FetchOrderState(loading: true, success: false, message: "", orders: []));
      ApiResponse? response = await fetchOrderUseCase(NoParams());
      if(response?.success==true){
        emit(FetchOrderState(loading: false, success: true, message: response?.message.toString() ?? "Order fetch successfully", orders: response?.data));
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
