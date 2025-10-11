import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/services/connectivity/connectivity.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/domain/entities/cart.dart';
import 'package:speedy_chow/features/cart/domain/use_case/delete_cart_use_case.dart';
import 'package:speedy_chow/features/cart/domain/use_case/fetch_user_cart_use_case.dart';
import 'package:speedy_chow/features/cart/domain/use_case/update_cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  List<Cart> items=[];
  int totalPrice=0;

  final FetchCartProductsUseCase fetchCartProductsUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartBloc({
    required this.fetchCartProductsUseCase,
    required this.updateCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartInitial()) {
    on<CartFetchUserCartEvent>(_fetchUserCart);
    on<UpdateCartEvent>(_updateCart);
    on<DeleteCartEvent>(_deleteCart);
  }

  void _fetchUserCart(CartFetchUserCartEvent event, Emitter<CartState> emit) async{
    try {
      emit(CartFetchUserCartState(
          msg: "loading",
          loading: true,
          success: false,
          totalPrice: 0,
          data: []));
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await fetchCartProductsUseCase(NoParams());

      if(response?.success==true){
        totalPrice= calTotalPrice(response?.data);
        items=response?.data ?? [];
        emit(CartFetchUserCartState(
            msg: response?.message ?? "Cart fetched ",
            loading: false,
            success: true,
            totalPrice: totalPrice,
            data: response?.data ?? []
        ));

      }else{
        emit(CartFetchUserCartState(
            msg: response?.message ?? "",
            loading: false,
            success: false,
            totalPrice: 0,
            data: response?.data ?? [] ));
      }
      }else{
        emit(CartFetchUserCartState(
            msg: "No internet!",
            loading: false,
            success: false,
            totalPrice: 0,
            data:  []));
      }


    } catch (e) {
      emit(CartFetchUserCartState(
          msg: e.toString(),
          loading: false,
          success: false,
          totalPrice: 0,
          data:  []));
    }
  }

  void _updateCart(UpdateCartEvent event,Emitter<CartState> emit) async{
    try{
      emit(UpdateCartState(msg: "", loading: true, success: false));
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await updateCartUseCase(UpdateCartParam(cartId: event.cart.id.toString(), data: {"quantity":event.quantity}));
      if(response?.success==true){
        int index = items.indexOf(event.cart);
        items[index]=response?.data as Cart;
        totalPrice=calTotalPrice(items);
        emit(UpdateCartState(msg: response?.message.toString() ?? "Item updated successfully", loading: false, success: true));
      }else{
        emit(UpdateCartState(msg: response?.message.toString() ?? "Item Not Updated", loading: false, success: false));
      }}else{
        emit(UpdateCartState(msg: "No internet!", loading: false, success: false));

      }
    }catch(e){
      emit(UpdateCartState(msg: e.toString(), loading: false, success: false));
    }
  }

  void _deleteCart(DeleteCartEvent event,Emitter<CartState> emit)async{
    try{
      emit(DeleteCartState(msg: "", loading: true, success: false));
      if(await CheckConnectivity.checkConnectivity()){
      ApiResponse? response=await deleteCartUseCase(DeleteCartParam(cartId: event.cart.id.toString()));
      if(response?.success==true){
        items.remove(event.cart);
        totalPrice=calTotalPrice(items);
        emit(DeleteCartState(msg: response?.message.toString() ?? "Item deleted successfully", loading: false, success: true));
      }else{
        emit(DeleteCartState(msg: response?.message.toString() ?? "Item Not deleted", loading: false, success: false));
      }}else{
        emit(DeleteCartState(msg: "No internet!", loading: false, success: false));
      }
    }catch(e){
      emit(DeleteCartState(msg: e.toString(), loading: false, success: false));
    }
  }
}




