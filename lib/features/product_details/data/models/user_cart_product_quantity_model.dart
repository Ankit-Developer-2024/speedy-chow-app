import 'package:speedy_chow/features/product_details/domain/entities/user_cart_product_quantity.dart';

class UserCartProductQuantityModel extends UserCartProductQuantity{
  UserCartProductQuantityModel({required super.quantity, required super.cartId});

  factory UserCartProductQuantityModel.fromJson(Map<String,dynamic> json){
    return UserCartProductQuantityModel(
        quantity: json["quantity"] ?? 0,
        cartId: json["id"]??"");
  }

  static UserCartProductQuantityModel createResponseModel(List<dynamic> json){
    if(json.isEmpty){
      return UserCartProductQuantityModel(quantity: 0, cartId: '');
    }else{
      return  UserCartProductQuantityModel.fromJson(json[0]);}
  }

  static UserCartProductQuantityModel createResponseModelWithMap(Map<String,dynamic> json) {
    return UserCartProductQuantityModel.fromJson(json);
  }


}