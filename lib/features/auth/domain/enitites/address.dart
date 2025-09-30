import 'package:equatable/equatable.dart';

class Address extends Equatable{
  String? id;
  String? houseNo;
  String? street;
  String? city;
  String? landMark;
  String? state;
  String? zipCode;
  String? country;
  bool? isDefault;

  Address({
    required this.id,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.landMark,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.isDefault,
});

  @override
  List<Object?> get props => [houseNo,street,city,landMark,state,zipCode,country,isDefault];
}