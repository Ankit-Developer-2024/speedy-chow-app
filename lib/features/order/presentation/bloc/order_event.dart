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
