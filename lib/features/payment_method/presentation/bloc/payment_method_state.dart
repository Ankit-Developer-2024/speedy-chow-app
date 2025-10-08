part of 'payment_method_bloc.dart';

sealed class PaymentMethodState extends Equatable {}

final class PaymentMethodInitial extends PaymentMethodState {
  @override
  List<Object?> get props => [];
}

final class DefaultAddressState extends PaymentMethodState{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}

final class AddressPaymentMethodState extends PaymentMethodState{
  final String msg;
  final bool loading;
  final bool success;
  final UserModel user;

  AddressPaymentMethodState({required this.msg, required this.loading, required this.success,required this.user});

  @override
  List<Object?> get props => [msg,loading,success,user];
}

final class SelectDeliveryAddressState extends PaymentMethodState{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}



final class IsPaymentMethodErrorVisibleState extends PaymentMethodState{
  final bool isErrorVisible;

  IsPaymentMethodErrorVisibleState({required this.isErrorVisible});
  @override
  List<Object?> get props => [isErrorVisible];
}

final class SelectPaymentMethodState extends PaymentMethodState{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}

final class FetchCartState extends PaymentMethodState{
  final String msg;
  final bool loading;
  final bool success;
  final int totalPrice;
  final List<CartModel> data ;

  FetchCartState({required this.msg, required this.loading, required this.success,required this.totalPrice, required this.data});


  @override
  List<Object?> get props => [msg,loading,success,totalPrice,data];
}


final class CreateOrderState extends PaymentMethodState{
  final String msg;
  final bool loading;
  final bool success;
  final CreateOrder createOrder;

  CreateOrderState({required this.msg, required this.loading, required this.success, required this.createOrder});

  @override
  List<Object?> get props => [msg,loading,success,createOrder];

}

final class RazorpayPaymentNotifyErrorState extends PaymentMethodState{
  final String msg;

  RazorpayPaymentNotifyErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];

}