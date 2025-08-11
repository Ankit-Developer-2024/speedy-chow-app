part of 'cart_bloc.dart';


sealed class CartState extends Equatable {}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartFetchUserCartState extends CartState{
  final String msg;
  final bool loading;
  final bool success;
  final int totalPrice;
  final List<Cart> data ;

  CartFetchUserCartState({required this.msg, required this.loading, required this.success,required this.totalPrice, required this.data});


  @override
  List<Object?> get props => [msg,loading,success,totalPrice,data];
}

final class UpdateCartState extends CartState{
  final String msg;
  final bool loading;
  final bool success;

  UpdateCartState({required this.msg, required this.loading, required this.success});

  @override
  List<Object?> get props => [msg,loading,success];
}
