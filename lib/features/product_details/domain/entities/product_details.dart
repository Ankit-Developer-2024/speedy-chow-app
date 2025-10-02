import 'dart:typed_data';

class ProductDetails{
  final String? id;
  final String? name;
  final String? description;
  final String? img;
  final String? category;
  final int? price;
  final int? discountPercentage;
  final int? discountedPrice;
  final double? rating;
  final int? quantity;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.img,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.rating,
    required this.quantity,
  });

}