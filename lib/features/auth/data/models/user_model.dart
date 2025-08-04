import 'package:speedy_chow/features/auth/data/models/address_model.dart';
import 'package:speedy_chow/features/auth/domain/enitites/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.gender,
      required super.phone,
      required super.dob,
      required super.image,
      required super.addresses,
      required super.role});

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        id: json["id"]??"",
        name: json['name']??"",
        email: json["email"] ?? "",
        gender: json["gender"]??"",
        phone: json["phone"]??"",
        dob: json["dob"]??"",
        image: json["image"]??"",
        addresses: json["addresses"]==null ? null : (json["addresses"] as List).map((val)=>AddressModel.fromJson(val)).toList(),
        role: json["role"]??"");
  }

  static UserModel createResponseModel(Map<String,dynamic> json){
    return UserModel.fromJson(json);
  }

}

