import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.name,
      required super.description,
      required super.img,
      required super.category,
      required super.price,
      required super.discountPercentage,
      required super.rating,
      required super.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json["name"],
        description: json["description"],
        img: json["img"],
        category: json["category"],
        price: json["price"],
        discountPercentage: json["discount"],
        rating:json["rating"],
        quantity: json["quantity"]);
  }

  static List<ProductModel> createResponseModel(List<Map<String,dynamic>> json){
    List<ProductModel> products=(json as List).map((product) {
      return ProductModel.fromJson(product);
    }).toList();
    return  products;
  }
}
