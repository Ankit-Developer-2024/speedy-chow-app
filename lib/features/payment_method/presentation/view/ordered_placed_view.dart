import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart';
import 'package:speedy_chow/core/components/widgets/h_axis_line.dart';

class OrderedPlacedView extends StatelessWidget {
  const OrderedPlacedView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop,dynamic data){
        context.read<NavigationBloc>().add(
          NavigationTabChangedEvent(index: 0),
        );
      },
      child: Scaffold(
         appBar:  AppBar(
           shadowColor: AppColors.grey10.withAlpha(100),
           leading: IconButton(
             onPressed: () {
               context.read<NavigationBloc>().add(
                 NavigationTabChangedEvent(index: 0),
               );
             },
             icon: Icon(
               Icons.arrow_back_ios_new_sharp,
               size: AppDimensions.size_18,
             ),
           ),
         ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            top: AppDimensions.spacing_10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppDimensions.spacing_10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle,color: AppColors.green900,),
                  Text(AppLocal.orderedPlaced.getString(context),style: AppTextStyles.semiBold20P(color: AppColors.green900),)
                ],
              ),
              Text(AppLocal.confirmationSentToEmail.getString(context),style: AppTextStyles.medium14P(),),
              HAxisLine(),
              Text("${AppLocal.shippingTo.getString(context)} ${context.read<PaymentMethodBloc>().userModel?.name},",style: AppTextStyles.semiBold16P(),),
              GetAddress(address:context.read<PaymentMethodBloc>().selectedAddressModel, textStyle: null),
              SizedBox(height: AppDimensions.spacing_10,),
              Center(
                child: Button(
                    width: AppDimensions.size_150,
                    onTap: (){
                      context.read<NavigationBloc>().add(
                        NavigationTabChangedEvent(index: 0),
                      );
                    }, child: Center(child: Text(AppLocal.backToCart.getString(context),style: AppTextStyles.medium18P(color: AppColors.white),))),
              )

            ],
          ),
        ),
      ),
    );
  }
}
