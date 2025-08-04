import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/product_detail_fetch_product_use_case.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailFetchProductUseCase productDetailFetchProductUseCase;

  int totalProductQuantity=1;

  ProductDetailBloc({required this.productDetailFetchProductUseCase})
      : super(ProductDetailInitial()) {
    on<ProductDetailIncAndDecProductQuantityEvent>(_incAndDecProductQuantity);
    on<ProductDetailFetchProductEvent>(_fetchProduct);
    on<ProductDetailAddProductInCartEvent>(_addToCart);
  }

  void _fetchProduct(ProductDetailFetchProductEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailFetchProductState(
        msg: "",
        loading: true,
        success: false,
        data: ProductDetails(
            name: null,
            description: null,
            img: null,
            category: null,
            price: null,
            discountPercentage: null,
            discountedPrice: null,
            rating: null,
            quantity: null)));

    try {
      ApiResponse? response = await productDetailFetchProductUseCase(
          ProductDetailParam(productId: event.productId));
      if (response?.success == true) {
        emit(ProductDetailFetchProductState(
            msg: response?.message ?? '',
            loading: false,
            success: true ,
            data: response?.data ));
      } else {
        emit(ProductDetailFetchProductState(
            msg: response?.message ?? "Something went wrong!",
            loading: false,
            success: response?.success ?? false,
            data: response?.data ?? ProductDetails(
                name: null,
                description: null,
                img: null,
                category: null,
                price: null,
                discountPercentage: null,
                discountedPrice: null,
                rating: null,
                quantity: null)));
      }
    } catch (e) {
      emit(ProductDetailFetchProductState(
          msg: e.toString(),
          loading: false,
          success: false,
          data: ProductDetails(
              name: null,
              description: null,
              img: null,
              category: null,
              price: null,
              discountPercentage: null,
              discountedPrice: null,
              rating: null,
              quantity: null)));
    }
  }

  void _incAndDecProductQuantity(
      ProductDetailIncAndDecProductQuantityEvent event,
      Emitter<ProductDetailState> emit) {
    totalProductQuantity=event.quantity;
    emit(ProductDetailIncAndDecProductQuantityState(quantity: event.quantity));
  }

  void _addToCart(ProductDetailAddProductInCartEvent event,Emitter<ProductDetailState> emit)async{
    emit(ProductDetailAddProductInCartState(loading: true, success: false, msg: ""));
    await Future.delayed(Duration(seconds: 2));

    emit(ProductDetailAddProductInCartState(loading: false, success: true, msg: "Sucess"));

  }
}
