import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/cart/domain/entities/cart.dart';

class Order{
  final String? id;
  final List<Cart>? items;
  final int? totalAmount;
  final int? totalItems;
  final String? paymentMethod;
  final OrderStatus status;
  final String? statusReason;
  final Address? address;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.totalItems,
    required this.paymentMethod,
    required this.status,
    required this.statusReason,
    required this.address
  });
}