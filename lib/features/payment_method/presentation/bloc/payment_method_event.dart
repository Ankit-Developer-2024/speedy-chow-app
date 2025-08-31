part of 'payment_method_bloc.dart';


sealed class PaymentMethodEvent extends Equatable {}

final class AddAddressPaymentMethodEvent extends PaymentMethodEvent{
  final UserModel user;
  final Map<String,dynamic> data;

  AddAddressPaymentMethodEvent({required this.data,required this.user});

  @override
  List<Object?> get props => [data,user];
}

final class DefaultAddressEvent extends PaymentMethodEvent{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}

final class UpdateAddressPaymentMethodEvent extends PaymentMethodEvent{
  final String id;
  final UserModel user;
  final Map<String,dynamic> data;

  UpdateAddressPaymentMethodEvent({required this.data,required this.user,required this.id});

  @override
  List<Object?> get props => [data,user,id];
}


final class SelectDeliveryAddressEvent extends PaymentMethodEvent{
  final Address address;

  SelectDeliveryAddressEvent({required this.address});
  @override
  List<Object?> get props => [address];
}

final class IsPaymentMethodErrorVisibleEvent extends PaymentMethodEvent{
  final bool isErrorVisible;

  IsPaymentMethodErrorVisibleEvent({required this.isErrorVisible});
  @override
  List<Object?> get props => [isErrorVisible];

}

final class SelectPaymentMethodEvent extends PaymentMethodEvent{
  final String paymentMethod;

  SelectPaymentMethodEvent({required this.paymentMethod});
  @override
  List<Object?> get props => [paymentMethod];
}

final class FetchCartEvent extends PaymentMethodEvent{
  final DateTime dateTime=DateTime.now();
  @override
  List<Object?> get props => [dateTime];
}

final class CreateOrderEvent extends PaymentMethodEvent{
  final String user;
  final List<Map<String,dynamic>> items;
  final int totalAmount;
  final int totalItems;
  final String paymentMethod;
  final Map<String,dynamic> selectedAddress;

  CreateOrderEvent({required this.user, required this.items, required this.totalAmount, required this.totalItems, required this.paymentMethod, required this.selectedAddress});
  @override
  List<Object?> get props => [user,items,totalAmount,totalItems,paymentMethod,selectedAddress];

}