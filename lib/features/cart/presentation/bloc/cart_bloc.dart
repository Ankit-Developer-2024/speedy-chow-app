import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/cart/domain/enitites/cart.dart';
import 'package:speedy_chow/features/cart/domain/use_case/fetch_user_cart_use_case.dart';
import 'package:speedy_chow/features/cart/domain/use_case/update_cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  List<Cart> items=[];
  int totalPrice=0;

  final FetchCartProductsUseCase fetchCartProductsUseCase;
  final UpdateCartUseCase updateCartUseCase;

  CartBloc({required this.fetchCartProductsUseCase,required this.updateCartUseCase}) : super(CartInitial()) {
    on<CartFetchUserCartEvent>(_fetchUserCart);
    on<UpdateCartEvent>(_updateCart);
  }

  void _fetchUserCart(CartFetchUserCartEvent event, Emitter<CartState> emit) async{
    try {
      emit(CartFetchUserCartState(
          msg: "loading",
          loading: true,
          success: false,
          totalPrice: 0,
          data: []));
      ApiResponse? response=await fetchCartProductsUseCase(NoParams());

      if(response?.success==true){
        totalPrice= _totalPrice(response?.data);
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

      ApiResponse? response=await updateCartUseCase(UpdateCartParam(cartId: event.cart.id.toString(), data: {"quantity":event.quantity}));
      if(response?.success==true){
        int index = items.indexOf(event.cart);
        items[index]=response?.data as Cart;
        totalPrice=_totalPrice(items);
        emit(UpdateCartState(msg: response?.message.toString() ?? "Item updated successfully", loading: false, success: true));
      }else{
        emit(UpdateCartState(msg: response?.message.toString() ?? "Item Not Updated", loading: false, success: false));
      }
    }catch(e){
      emit(UpdateCartState(msg: e.toString(), loading: false, success: false));
    }
  }


}

int _totalPrice(List<Cart> items){

  if(items.isEmpty){return 0;}

  int price=0;
  for(int i=0;i<items.length;i++){
    price+=items[i].quantity! * items[i].product!.discountedPrice!;
  }
  return price;
}


