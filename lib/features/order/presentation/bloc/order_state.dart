part of 'order_bloc.dart';


sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class FetchOrderState extends OrderState{
  final bool loading;
  final bool success;
  final String message;
  final List<Order> orders;

  FetchOrderState({
    required this.loading,
    required this.success,
    required this.message,
    required this.orders
  });

  List<Object?> get props => [loading,success,message,orders];

}

final class FetchOrderDetailsState extends OrderState{
  final bool loading;
  final bool success;
  final String message;
  final Order? order;

  FetchOrderDetailsState({
    required this.loading,
    required this.success,
    required this.message,
    required this.order
  });

  List<Object?> get props => [loading,success,message,order];

}

final class UpdateOrderState extends OrderState{
  final bool loading;
  final bool success;
  final String message;
  final Order? order;

  UpdateOrderState({
    required this.loading,
    required this.success,
    required this.message,
    required this.order
  });

  List<Object?> get props => [loading,success,message,order];
}

final class SelectedAddressState extends OrderState{
  final DateTime date=DateTime.now();
  List<Object?> get props => [date];
}

final class SelectPaymentMethodState extends OrderState{
  final DateTime date=DateTime.now();
  List<Object?> get props => [];
}

final class IsPaymentMethodErrorVisibleState extends OrderState{
  final bool isErrorVisible;

  IsPaymentMethodErrorVisibleState({required this.isErrorVisible});
  List<Object?> get props => [isErrorVisible];
}

final class CreateOrderState extends OrderState{
  final String msg;
  final bool loading;
  final bool success;
  final CreateOrder createOrder;

  CreateOrderState({required this.msg, required this.loading, required this.success, required this.createOrder});

  List<Object?> get props => [msg,loading,success,createOrder];

}


final class RazorpayPaymentNotifyErrorOrderState extends OrderState{
  final String msg;

  RazorpayPaymentNotifyErrorOrderState({required this.msg});

  List<Object?> get props => [msg];

}