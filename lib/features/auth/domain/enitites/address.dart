import 'package:equatable/equatable.dart';

class Address extends Equatable{
 final String? id;
 final String? houseNo;
 final String? street;
 final String? city;
 final String? landMark;
 final String? state;
 final String? zipCode;
 final String? country;
 final bool? isDefault;

  const Address({
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