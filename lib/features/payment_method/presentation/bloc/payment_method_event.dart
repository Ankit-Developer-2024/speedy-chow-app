part of 'payment_method_bloc.dart';

@immutable
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
