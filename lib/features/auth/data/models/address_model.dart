import 'package:speedy_chow/features/auth/domain/enitites/address.dart';

class AddressModel extends Address{
  AddressModel({
    required super.street,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.country,
    required super.isDefault});

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        street: json["street"]??"",
        city: json["city"]??"",
        state: json["state"]??"",
        zipCode: json["zipCode"]??"",
        country: json["country"]??"",
        isDefault: json["isDefault"]??false
    );

  }
}