import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/address_bottom_sheet.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/change_address_bottom_sheet.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/get_address.dart';

class UserDeliveryAddress extends StatelessWidget {
  const UserDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.spacing_10,
      children: [
        Text(
          "${AppLocal.deliveryTo.getString(context)} ${context.read<AuthBloc>().userModel?.name != null ? context.read<AuthBloc>().userModel?.name.toString() : ""}",
          style: AppTextStyles.semibold18P(),
        ),

       (context.read<PaymentMethodBloc>().addressModel!=null )
        ? BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
         builder: (context, state) {
                 return GetAddress(address: context.read<PaymentMethodBloc>().addressModel!,textStyle: null,);
             },
          )
          : InkWell(
          onTap: (){
            addressBottomSheet(context);
          },
          borderRadius: BorderRadius.circular(AppDimensions.radius_8),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radius_8),
              border: Border.all(color: AppColors.grey500)
            ),
            child: Center(child: Icon(Icons.add,color: AppColors.grey500,size: AppDimensions.size_32,)),
          ),
        ),

        TextButton(
            onPressed: (){
               changeAddressBottomSheet(context);
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: AppDimensions.spacing_4)),
            ),
            child: Text(AppLocal.changeDeliveryAddress.getString(context),style: AppTextStyles.medium14P(color: AppColors.darkOrange),)
        ),
        Container(
          height: AppDimensions.size_1,
          decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(AppDimensions.radius_100)
          ),
        )
      ],
    );
  }
}
