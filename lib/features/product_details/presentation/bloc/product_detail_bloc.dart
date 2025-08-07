import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';
import 'package:speedy_chow/features/product_details/domain/entities/user_cart_product_quantity.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/add_product_to_cart_use_case.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/product_detail_fetch_product_use_case.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/update_cart_quantity_use_case.dart';
import 'package:speedy_chow/features/product_details/domain/use_case/user_cart_product_quantity_use_case.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailFetchProductUseCase productDetailFetchProductUseCase;
  final UserCartProductQuantityUseCase userCartProductQuantityUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final AddProductToCartUseCase addProductToCartUseCase;

  int totalQuantity=1;
  bool isProductAlreadyAddedToCart=false;
  String? cartId;

  ProductDetailBloc({
    required this.productDetailFetchProductUseCase,
    required this.userCartProductQuantityUseCase,
    required this.updateCartQuantityUseCase,
    required this.addProductToCartUseCase,
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
            id: null,
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
                id: null,
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
              id: null,
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
            quantity: null, cartId: null)));

    try {
      print("=====================${event.productId}");
      ApiResponse? response = await userCartProductQuantityUseCase(
          UserCartProductQuantityParam(productId: event.productId));
      if (response?.success == true) {
        UserCartProductQuantity userCartProductQuantity=response?.data;
         if(userCartProductQuantity.quantity!=0){
           isProductAlreadyAddedToCart=true;
           cartId=userCartProductQuantity.cartId;
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
                quantity: null, cartId: null)));
      }
    } catch (e) {
      emit(ProductQuantityUserCartFetchState(
          msg: e.toString(),
          loading: false,
          success: false,
          data: UserCartProductQuantity(
              quantity: null, cartId: null)));
    }
  }



  void _incAndDecProductQuantity(
      ProductDetailIncAndDecProductQuantityEvent event,
      Emitter<ProductDetailState> emit) async{
      try{
        emit(ProductDetailIncAndDecProductQuantityState(quantity: totalQuantity,message: "",success: false,loading: true));
        totalQuantity=event.quantity;
        if(cartId!=null && cartId!.isNotEmpty){
          //when item already in cart
          ApiResponse? response=await updateCartQuantityUseCase(UpdateCartQuantityParam(cartId: cartId!, data: {"quantity":totalQuantity}));
          if(response?.success==true){ 
            emit(ProductDetailIncAndDecProductQuantityState(quantity: totalQuantity,message: "Quantity Update Success",success: true,loading: false));
          }else{
            totalQuantity--;
            emit(ProductDetailIncAndDecProductQuantityState(quantity: totalQuantity,message: "",success: false,loading: false));
          }
        }else{
          //when item already not in cart
          emit(ProductDetailIncAndDecProductQuantityState(quantity: totalQuantity,message: "",success: true,loading: false));
        }
      }catch(err){
        totalQuantity--;
        emit(ProductDetailIncAndDecProductQuantityState(quantity: totalQuantity,message: err.toString(),success:false,loading: false));
      }
  }

  void _addToCart(ProductDetailAddProductInCartEvent event,Emitter<ProductDetailState> emit)async{
    emit(ProductDetailAddProductInCartState(loading: true, success: false, msg: ""));
    try{
      ApiResponse? response=await addProductToCartUseCase(AddProductToCartParam(data: {"quantity":totalQuantity,"productId":event.product.id}));
      if(response?.success==true){
        isProductAlreadyAddedToCart=true;
        emit(ProductDetailAddProductInCartState(loading: false, success: true, msg: response!.message.toString()));
      }else{
        emit(ProductDetailAddProductInCartState(loading: false, success: false, msg: response!.message.toString()));
      }
    }catch(err){
      emit(ProductDetailAddProductInCartState(loading: false, success: false, msg: err.toString()));
    }

   
  }
}
