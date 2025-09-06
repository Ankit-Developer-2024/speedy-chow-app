import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/primary_button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/delivering_address_details.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/h_axis_line.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/items_details.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/paying_method_details.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/total_rupee_details.dart';

class CreateOrderView extends StatefulWidget {
  const CreateOrderView({super.key});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            top: AppDimensions.spacing_10,
          ),
          child: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.start,
           spacing: AppDimensions.spacing_10,
           children: [
             PrimaryButton(
               onPress: (){
                 context.read<PaymentMethodBloc>().add(CreateOrderEvent(
                     items: context.read<PaymentMethodBloc>().items.map((item)=>item.toJson()).toList(),
                     totalAmount: context.read<PaymentMethodBloc>().totalPrice,
                     totalItems: context.read<PaymentMethodBloc>().items.length,
                     paymentMethod: context.read<PaymentMethodBloc>().paymentMethod,
                     selectedAddress:context.read<PaymentMethodBloc>().selectedAddressModel == null
                         ? {}
                         : context.read<PaymentMethodBloc>().selectedAddressModel!.toJson()
                 ));
               },
               title:AppLocal.placeYourOrder.getString(context),
               titleStyle: AppTextStyles.medium18P(color: AppColors.white),
             ),
             HAxisLine(),
             TotalRupeeDetails(),
             HAxisLine(),
             PayingMethodDetails(),
             HAxisLine(),
             DeliveringAddressDetails(),
             HAxisLine(),
             ItemsDetails(),
             HAxisLine(),
             BlocListener<PaymentMethodBloc, PaymentMethodState>(
              listenWhen: (prev,curr)=>curr is CreateOrderState,
              listener: (context, state) {
                   if(state is CreateOrderState){
                     if(state.loading==true){
                       customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
                     }else if(state.success==true){
                       context.pop();
                       context.pushReplacementNamed(AppRoutes.orderPlaced,extra: context.read<PaymentMethodBloc>());
                     }else if(state.success==false){
                       context.pop();
                       customSnackBar(context, state.msg,bgColor: AppColors.red800);
                     }
                   }
               },
              child: PrimaryButton(
               onPress: (){
                  context.read<PaymentMethodBloc>().add(CreateOrderEvent(
                      items: context.read<PaymentMethodBloc>().items.map((item)=>item.toJson()).toList(),
                      totalAmount: context.read<PaymentMethodBloc>().totalPrice,
                      totalItems: context.read<PaymentMethodBloc>().items.length,
                      paymentMethod: context.read<PaymentMethodBloc>().paymentMethod,
                      selectedAddress:context.read<PaymentMethodBloc>().selectedAddressModel == null
                          ? {}
                          : context.read<PaymentMethodBloc>().selectedAddressModel!.toJson()
                  ));

             },
               title:AppLocal.placeYourOrder.getString(context),
               titleStyle: AppTextStyles.medium18P(color: AppColors.white),
               ),
              ),

           ],
          ),
        ),
      ),
    );
  }
}
