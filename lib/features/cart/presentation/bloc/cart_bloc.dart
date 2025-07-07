import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/features/cart/domain/enitites/cart.dart';
import 'package:speedy_chow/features/cart/domain/use_case/fetch_user_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FetchUserCart fetchUserCart;
  CartBloc({required this.fetchUserCart}) : super(CartInitial()) {
    on<CartFetchUserCartEvent>(_fetchUserCart);
  }

  void _fetchUserCart(CartFetchUserCartEvent event, Emitter<CartState> emit) async{
    try {
      emit(CartFetchUserCartState(
          msg: "loading",
          loading: true,
          success: false,
          data: Cart(totalPrice: null, cartItem: null)));
      ApiResponse? response=await fetchUserCart(UserCartParam(userId: "userId"));

      if(response?.success==true){
        emit(CartFetchUserCartState(
            msg: response?.message ?? "Cart fetched ",
            loading: false,
            success: true,
            data: response?.data
        ));
      }else{

        emit(CartFetchUserCartState(
            msg: response?.message ?? "",
            loading: false,
            success: false,
            data: Cart(totalPrice: null, cartItem: null)));
      }

    } catch (e) {
      print(e.toString());
      emit(CartFetchUserCartState(
          msg: e.toString(),
          loading: false,
          success: false,
          data: Cart(totalPrice: null, cartItem: null)));
    }
  }
}
