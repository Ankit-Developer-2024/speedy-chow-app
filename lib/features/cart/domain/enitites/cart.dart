import 'package:speedy_chow/features/home/domain/enitites/product.dart';

class Cart{
  final double? totalPrice;
  final List<Product>? cartItem;

  Cart({required this.totalPrice, required this.cartItem});
}