import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';

class GetAddress extends StatelessWidget {
  const GetAddress({super.key,required this.address,required this.textStyle});
  final Address? address;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return address==null ? SizedBox.shrink() : Text("${address?.houseNo} , ${address?.street} , ${address?.landMark} , ${address?.city} , ${address?.state} , ${address?.zipCode} , ${address?.country}",style: textStyle ?? AppTextStyles.medium16P(),maxLines: null,);
  }
}
