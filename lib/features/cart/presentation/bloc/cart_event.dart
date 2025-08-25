part of 'cart_bloc.dart';


sealed class CartEvent extends Equatable {}

final class CartFetchUserCartEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}

final class UpdateCartEvent extends CartEvent{
   final Cart cart;
   final int quantity;

  UpdateCartEvent({required this.cart,required this.quantity});

  @override
  List<Object?> get props => [cart,quantity];
}


final class DeleteCartEvent extends CartEvent{
   final Cart cart;

   DeleteCartEvent({required this.cart});

  @override
  List<Object?> get props => [cart];
}

