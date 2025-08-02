import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class ProductModel extends Product {
  ProductModel(
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
      required super.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        img: json["image"],
        category: json["category"],
        price: json["price"],
        discountPercentage: json["discountPercentage"],
        discountedPrice: json["discountedPrice"],
        rating:json["rating"],
        quantity: json["totalQuantity"]);
  }

  static List<ProductModel> createResponseModel(List<dynamic> json){
    List<ProductModel> products=(json).map((product) {
      return ProductModel.fromJson(product);
    }).toList();
    return  products;
  }
}
