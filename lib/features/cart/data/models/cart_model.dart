import 'package:speedy_chow/features/cart/domain/entities/cart.dart';
import 'package:speedy_chow/features/home/data/models/product_model.dart';

class CartModel extends Cart {
  CartModel({required super.id,required super.quantity ,required super.product});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json["id"] ??"",
        quantity: json["quantity"] ?? 1,
        product: json['product']!=null ? ProductModel.fromJson(json["product"]) : null
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "quantity":quantity,
      "product": product?.toJson()
    };
  }

  static List<CartModel> createResponseModelWithList(List<dynamic> json){
    List<CartModel> cartModels=(json).map((item)=>CartModel.fromJson(item)).toList();
    return cartModels;
   }


  static CartModel createResponseModel(Map<String,dynamic> json){
    return CartModel.fromJson(json);
   }
}
