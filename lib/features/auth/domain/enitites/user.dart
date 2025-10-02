import 'dart:typed_data';
import 'package:speedy_chow/core/components/models/address_model.dart';

class User{
  String? id;
  String? name;
  String? email;
  String? gender;
  int? phone;
  String? dob;
  String? image;
  List<AddressModel>? addresses;
  String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.phone,
    required this.dob,
    required this.image,
    required this.addresses,
    required this.role
  });
}