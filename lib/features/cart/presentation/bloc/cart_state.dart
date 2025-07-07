part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable {}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartFetchUserCartState extends CartState{
  final String msg;
  final bool loading;
  final bool success;
  final Cart data ;

  CartFetchUserCartState({required this.msg, required this.loading, required this.success, required this.data});


  @override
  List<Object?> get props => [msg,loading,success,data];
}
