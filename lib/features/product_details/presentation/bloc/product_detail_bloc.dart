import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';
import 'package:speedy_chow/features/product_details/domain/entities/user_cart_product_quantity.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/product_detail_fetch_product_use_case.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/user_cart_product_quantity_use_case.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailFetchProductUseCase productDetailFetchProductUseCase;
  final UserCartProductQuantityUseCase userCartProductQuantityUseCase;

  int totalProductQuantity=1;

  ProductDetailBloc({
    required this.productDetailFetchProductUseCase,
    required this.userCartProductQuantityUseCase
  })
      : super(ProductDetailInitial()) {
    on<ProductDetailIncAndDecProductQuantityEvent>(_incAndDecProductQuantity);
    on<ProductDetailFetchProductEvent>(_fetchProduct);
    on<ProductQuantityUserCartFetchEvent>(_fetchUserCartProduct);
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

  void _fetchUserCartProduct(ProductQuantityUserCartFetchEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductQuantityUserCartFetchState(
        msg: "",
        loading: true,
        success: false,
        data: UserCartProductQuantity(
            quantity: null)));

    try {
      ApiResponse? response = await userCartProductQuantityUseCase(
          UserCartProductQuantityParam(productId: event.productId));
      if (response?.success == true) {
        UserCartProductQuantity userCartProductQuantity=response?.data;
         if(userCartProductQuantity.quantity!=0){
           add(ProductDetailIncAndDecProductQuantityEvent(quantity: userCartProductQuantity.quantity!));
         }
        emit(ProductQuantityUserCartFetchState(
            msg: response?.message ?? '',
            loading: false,
            success: true ,
            data: response?.data ));
      } else {
        emit(ProductQuantityUserCartFetchState(
            msg: response?.message ?? "Something went wrong!",
            loading: false,
            success: response?.success ?? false,
            data: response?.data ?? UserCartProductQuantity(
                quantity: null)));
      }
    } catch (e) {
      emit(ProductQuantityUserCartFetchState(
          msg: e.toString(),
          loading: false,
          success: false,
          data: UserCartProductQuantity(
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
