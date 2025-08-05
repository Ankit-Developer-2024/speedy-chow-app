part of 'product_detail_bloc.dart';


sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

final class ProductDetailFetchProductEvent extends ProductDetailEvent{
  final String productId;

  const ProductDetailFetchProductEvent({required this.productId});
  @override
  List<Object?> get props => [productId];
}

final class ProductQuantityUserCartFetchEvent extends ProductDetailEvent{
  final String productId;

  const ProductQuantityUserCartFetchEvent({required this.productId});
  @override
  List<Object?> get props => [productId];
}

final class ProductDetailIncAndDecProductQuantityEvent extends ProductDetailEvent{
  final int quantity ;

  const ProductDetailIncAndDecProductQuantityEvent({required this.quantity});

  @override
  List<Object?> get props => [];

}

final class ProductDetailAddProductInCartEvent extends ProductDetailEvent{
  final ProductDetails product;

  const ProductDetailAddProductInCartEvent({required this.product});

  @override
  List<Object?> get props => [product];

}