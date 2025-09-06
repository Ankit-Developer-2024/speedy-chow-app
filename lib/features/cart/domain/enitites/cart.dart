import 'package:speedy_chow/features/home/data/models/product_model.dart';
import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class Cart{
  final String? id;
  final int? quantity;
  final ProductModel? product;

  Cart({required this.id,required this.quantity,required this.product});
}