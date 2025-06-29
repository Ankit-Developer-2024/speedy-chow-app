import 'package:speedy_chow/features/home/domain/enitites/product.dart';
import 'package:speedy_chow/features/product_details/domain/entities/product_details.dart';

class ProductDetailModel extends ProductDetails {
  ProductDetailModel(
      {required super.name,
        required super.description,
        required super.img,
        required super.category,
        required super.price,
        required super.discountPercentage,
        required super.rating,
        required super.quantity});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
        name: json["name"],
        description: json["description"],
        img: json["img"],
        category: json["category"],
        price: json["price"],
        discountPercentage: json["discount"],
        rating:json["rating"],
        quantity: json["quantity"]);
  }

  static ProductDetailModel createResponseModel(List<Map<String,dynamic>> json){
    return  ProductDetailModel.fromJson(json[0]);
  }
}
