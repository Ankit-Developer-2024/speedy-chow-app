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