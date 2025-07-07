import 'package:speedy_chow/features/cart/domain/enitites/cart.dart';
import 'package:speedy_chow/features/home/data/models/product_model.dart';
import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class CartModel extends Cart {
  CartModel({required super.totalPrice, required super.cartItem});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        totalPrice: json["totalPrice"] ?? 0.0,
        cartItem: json['cartItem']!=null ? (json['cartItem'] as List).map<ProductModel>((item)=> ProductModel.fromJson(item)).toList() : []
    );
  }

  static CartModel createResponseModel(Map<String,dynamic> json){
    return CartModel.fromJson(json);
  }
}
