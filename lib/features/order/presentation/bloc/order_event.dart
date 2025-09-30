part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {}

final class FetchOrderEvent extends OrderEvent{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];

}

final class FetchOrderDetailsEvent extends OrderEvent{
  final String id;

  FetchOrderDetailsEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

final class UpdateOrderEvent extends OrderEvent{
  final String id;
  final Map<String,dynamic> data;

  UpdateOrderEvent({required this.id,required this.data});
  @override
  List<Object?> get props => [id,data];
}

final class SelectedAddressEvent extends OrderEvent{
  final DateTime date=DateTime.now();
  @override
  List<Object?> get props => [];
}

final class SelectPaymentMethodEvent extends OrderEvent{
  final DateTime date=DateTime.now();
  @override
  List<Object?> get props => [];
}

final class IsPaymentMethodErrorVisibleEvent extends OrderEvent{
  final bool isErrorVisible;

  IsPaymentMethodErrorVisibleEvent({required this.isErrorVisible});
  @override
  List<Object?> get props => [isErrorVisible];
}

final class CreateOrderEvent extends OrderEvent{
  final List<Map<String,dynamic>> items;
  final int totalAmount;
  final int totalItems;
  final String paymentMethod;
  final Map<String,dynamic> selectedAddress;

  CreateOrderEvent({required this.items, required this.totalAmount, required this.totalItems, required this.paymentMethod, required this.selectedAddress});
  @override
  List<Object?> get props => [items,totalAmount,totalItems,paymentMethod,selectedAddress];

}