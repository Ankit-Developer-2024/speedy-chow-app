import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class Cart{
  final String? id;
  final int? quantity;
  final Product? product;

  Cart({required this.id,required this.quantity,required this.product});
}