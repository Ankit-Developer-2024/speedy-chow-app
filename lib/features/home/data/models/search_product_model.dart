import 'package:speedy_chow/features/home/domain/entities/search_product.dart';

class SearchProductModel extends SearchProduct {
  SearchProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.discountedPrice});

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
        id: json["_id"] ?? "",
        name: json["name"],
        image: json['image'],
        discountedPrice: json["discountedPrice"],
    );
  }

  static List<SearchProductModel> createResponseModel(List<dynamic> json){
    List<SearchProductModel> products=(json).map((product) {
      return SearchProductModel.fromJson(product);
    }).toList();
    return  products;
  }
}
