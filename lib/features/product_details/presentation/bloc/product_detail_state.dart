part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();
}

final class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

final class ProductDetailFetchProductState extends ProductDetailState{
  final String msg;
  final bool loading;
  final bool success;
  final ProductDetails data ;

  const ProductDetailFetchProductState({
    required this.msg,
    required this.loading,
    required this.success,
    required this.data
  });


  @override
  List<Object> get props => [msg,loading,success,data];
}

final class ProductQuantityUserCartFetchState extends ProductDetailState{
  final String msg;
  final bool loading;
  final bool success;
  final UserCartProductQuantity data ;

  const ProductQuantityUserCartFetchState({
    required this.msg,
    required this.loading,
    required this.success,
    required this.data
  });


  @override
  List<Object> get props => [msg,loading,success,data];
}

final class ProductDetailIncAndDecProductQuantityState extends ProductDetailState{
  final int quantity;

  const ProductDetailIncAndDecProductQuantityState({required this.quantity});

  @override
  List<Object?> get props => [quantity];

}


final class ProductDetailAddProductInCartState extends ProductDetailState{
  final bool loading;
  final bool success;
  final String msg;

  const ProductDetailAddProductInCartState({required this.loading, required this.success,required this.msg});

  @override
  List<Object?> get props => [loading,success,msg];

}

