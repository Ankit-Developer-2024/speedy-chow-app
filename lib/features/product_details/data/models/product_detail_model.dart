import 'dart:typed_data';

import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';

class ProductDetailModel extends ProductDetails {
  ProductDetailModel(
      {
        required super.id,
        required super.name,
        required super.description,
        required super.img,
        required super.category,
        required super.price,
        required super.discountPercentage,
        required super.discountedPrice,
        required super.rating,
        required super.quantity,
      });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
        id: json["id"]??"",
        name: json["name"]??"",
        description: json["description"]??"",
        img:json['image'],
        category: json["category"]??"",
        price: json["price"]??0,
        discountPercentage: json["discountPercentage"]??0,
        discountedPrice: json["discountedPrice"]??0,
        rating:json["rating"]!=null ? double.parse(json["rating"].toString())  : 0.0,
        quantity: json["totalQuantity"]??0
    );
  }

  static Uint8List? getImageUint8List(dynamic data){
    if(data==null ){
      return null;
    }
    Uint8List bytes = Uint8List.fromList(List<int>.from(data['data']));
    return bytes;
  }

  static ProductDetailModel createResponseModel(Map<String,dynamic> json){
    return  ProductDetailModel.fromJson(json);
  }


}
