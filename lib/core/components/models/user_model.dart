import 'dart:typed_data';

import 'package:speedy_chow/core/components/models/address_model.dart';
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
        phone: json["phone"]??0,
        dob: json["dob"]??"",
        image:json["image"],
        addresses: json["addresses"]==null ? null : (json["addresses"] as List).map((val)=>AddressModel.fromJson(val)).toList(),
        role: json["role"]??"");
  }

  static Uint8List? getUint8ListImage(dynamic data){
    if(data==null ){
      return null;
    }
    Uint8List bytes = Uint8List.fromList(List<int>.from(data['data']));
    return bytes;

  }

  static UserModel createResponseModel(Map<String,dynamic> json){
    return UserModel.fromJson(json);
  }

}

