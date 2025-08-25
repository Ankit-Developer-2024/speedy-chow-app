part of 'payment_method_bloc.dart';

@immutable
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

