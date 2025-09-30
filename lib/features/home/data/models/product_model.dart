import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:speedy_chow/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {
      required super.id,
      required super.name,
      required super.description,
      required super.img,
      required super.imgType,
      required super.category,
      required super.price,
      required super.discountPercentage,
      required super.discountedPrice,
      required super.rating,
      required super.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        img: getImageUint8List(json['image']),
        imgType:json['imageType'] ??"",
        category: json["category"],
        price: json["price"],
        discountPercentage: json["discountPercentage"],
        discountedPrice: json["discountedPrice"],
        rating:json["rating"]!=null ? double.parse(json["rating"].toString())  : 0.0,
        quantity: json["totalQuantity"]);
  }

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "description":description,
      "image":getImageBuffer(img,imgType),
      "imageType":imgType,
      "category":category,
      "price":price,
      "discountPercentage":discountPercentage,
      "discountedPrice":discountedPrice,
      "rating":rating,
      "totalQuantity":quantity

    };
  }

  static Uint8List? getImageUint8List(dynamic data){
    if(data==null ){
      return null;
    }
    if(data is Map){
       Uint8List bytes = Uint8List.fromList(List<int>.from(data['data']));
       return bytes;
     }
    Uint8List bytes = Uint8List.fromList(List<int>.from(data));
    return bytes;
  }

  static Uint8List? getImageBuffer(Uint8List? data,String imgType){
    if(data==null) return null;
    return data;
    // String base64String = base64Encode(data);
    // String wrappedExpression= "Binary.createFromBase64($base64String)";


  }

  static List<ProductModel> createResponseModel(List<dynamic> json){
    List<ProductModel> products=(json).map((product) {
      return ProductModel.fromJson(product);
    }).toList();
    return  products;
  }
}
