part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {}

final class CartFetchUserCartEvent extends CartEvent{
  final String userId;

  CartFetchUserCartEvent({required this.userId});
  @override
  List<Object?> get props => [userId];
}
