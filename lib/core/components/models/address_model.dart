import 'package:speedy_chow/features/auth/domain/enitites/address.dart';

class AddressModel extends Address{
  AddressModel({
    required super.id,
    required super.street,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.country,
    required super.isDefault,
    required super.houseNo,
    required super.landMark
  });

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        id: json['id']??"",
        houseNo: json["houseNo"]??"",
        street: json["street"]??"",
        city: json["city"]??"",
        landMark: json["landMark"]??"",
        state: json["state"]??"",
        zipCode: json["zipCode"]??"",
        country: json["country"]??"",
        isDefault: json["isDefault"]??false
    );

  }
}