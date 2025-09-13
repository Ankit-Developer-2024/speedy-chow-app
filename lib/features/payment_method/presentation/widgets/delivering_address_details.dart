import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/change_address_bottom_sheet.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart';

class DeliveringAddressDetails extends StatelessWidget {
  const DeliveringAddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "${AppLocal.deliveryTo.getString(context)} ${context.read<AuthBloc>().userModel?.name != null ? context.read<AuthBloc>().userModel?.name.toString() : ""}",
          style: AppTextStyles.semibold18P(),
        ),
        BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
          buildWhen: (prev,curr)=>curr is SelectDeliveryAddressState,
          builder: (context, state) {
            return GetAddress(address: context.read<PaymentMethodBloc>().selectedAddressModel,textStyle: null,);
          },
        ),
        TextButton(onPressed: (){
          changeAddressBottomSheet(context);
        },
            style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: AppDimensions.spacing_4),),
                tapTargetSize:MaterialTapTargetSize.shrinkWrap
            ),
            child: Text(AppLocal.changeDeliveryAddress.getString(context),style:AppTextStyles.medium14P(color: AppColors.darkOrange),)
        )
      ],
    );
  }
}
