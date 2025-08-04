import 'package:speedy_chow/features/auth/domain/enitites/address.dart';

class User{
  String? id;
  String? name;
  String? email;
  String? gender;
  String? phone;
  String? dob;
  String? image;
  List<Address>? addresses;
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