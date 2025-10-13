import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart'; 
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';

Future buyAgainBottomSheet(BuildContext context)
{
  return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<OrderBloc>(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_8,
            children: [
              IconButton.filledTonal(
                color: AppColors.black,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close_sharp),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing_24,
                    vertical: AppDimensions.spacing_12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimensions.radius_16),
                        topRight: Radius.circular(AppDimensions.radius_16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: AppDimensions.spacing_4,
                  children: [
                    Text(
                      AppLocal.buyAgain.getString(context),
                      style: AppTextStyles.semiBold20P(),
                    ),
                    Text(
                      AppLocal.areYouSureBuyAgain.getString(context),
                      style: AppTextStyles.medium16P(),
                    ),
                    SizedBox(height: AppDimensions.spacing_8,),
                    Text(
                      AppLocal.selectAddress.getString(context),
                      style: AppTextStyles.semiBold18P(),
                    ),
                    BlocBuilder<OrderBloc, OrderState>(
                      buildWhen: (prev,curr)=> curr is SelectedAddressState,
                      builder: (context, state) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: context
                                .read<AuthBloc>()
                                .userModel
                                ?.addresses
                                ?.length,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              AddressModel? address = context
                                  .read<AuthBloc>()
                                  .userModel!
                                  .addresses?[index];
                              AddressModel? selectedAddress =context.read<OrderBloc>().selectedAddress;
                              return Container(
                                padding:
                                    EdgeInsets.all(AppDimensions.spacing_14),
                                decoration: BoxDecoration(
                                    color: address == selectedAddress
                                        ? AppColors.grey100
                                        : null,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radius_8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: AppDimensions.spacing_8,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: AppDimensions.spacing_6),
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<OrderBloc>()
                                              .selectedAddress = address;
                                          context
                                              .read<OrderBloc>()
                                              .add(SelectedAddressEvent());
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: AppDimensions.size_24,
                                              height: AppDimensions.size_24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimensions
                                                              .radius_100),
                                                  color: address ==
                                                          selectedAddress
                                                      ? AppColors.darkOrange
                                                      : null,
                                                  border:
                                                      address == selectedAddress
                                                          ? null
                                                          : Border.all(
                                                              color: AppColors
                                                                  .black_5)),
                                            ),
                                            Container(
                                              width: AppDimensions.size_10,
                                              height: AppDimensions.size_10,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimensions
                                                            .radius_100),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: AppDimensions.spacing_3,
                                        children: [
                                          Text(
                                            context
                                                .read<AuthBloc>()
                                                .userModel!
                                                .name
                                                .toString(),
                                            style: AppTextStyles.semiBold14P(),
                                          ),
                                          GetAddress(
                                            address: address!,
                                            textStyle:
                                                AppTextStyles.regular16P(),
                                          ),
                                          Text(
                                            "${AppLocal.phoneNumber.getString(context)} ${context.read<AuthBloc>().userModel!.phone.toString()}",
                                            style: AppTextStyles.regular16P(),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    SizedBox(height: AppDimensions.spacing_8,),
                    Text(
                      AppLocal.selectPaymentMethod.getString(context),
                      style: AppTextStyles.semiBold20P(),
                    ),
                    BlocBuilder<OrderBloc, OrderState>(
                      buildWhen: (prev,curr)=> curr is SelectPaymentMethodState,
                      builder: (context, state) {
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CheckboxMenuButton(
                              value: context.read<OrderBloc>().paymentMethod=="COD" ? true :false,
                              onChanged: (val) {
                                context.read<OrderBloc>().paymentMethod="COD";
                                context.read<OrderBloc>()..add(SelectPaymentMethodEvent())..add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
                              },
                              child: Text(
                                AppLocal.cashOnDelivery.getString(context),
                                style: AppTextStyles.medium14P(),
                              ),
                            ),
                            CheckboxMenuButton(
                              value: context.read<OrderBloc>().paymentMethod=="Razorpay" ? true :false,
                              onChanged: (val) {
                                context.read<OrderBloc>().paymentMethod="Razorpay";
                                context.read<OrderBloc>()..add(SelectPaymentMethodEvent())..add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
                              },
                              child: Text(AppLocal.razorpayPayment.getString(context), style: AppTextStyles.medium14P()),
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<OrderBloc,OrderState>(
                        buildWhen: (prev,curr)=>curr is IsPaymentMethodErrorVisibleState,
                        builder: (context,state){
                          if(state is IsPaymentMethodErrorVisibleState){
                            return state.isErrorVisible ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: AppDimensions.spacing_10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.error_rounded,color: AppColors.red1000,),
                                    Expanded(child: Text("Please select your payment information to continue.",style: AppTextStyles.medium14P(color: AppColors.red1000),)),
                                   ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: AppDimensions.spacing_10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.error_rounded,color: AppColors.red1000,),
                                    Expanded(child: Text("Please select your address to continue.",style: AppTextStyles.medium14P(color: AppColors.red1000),)),
                                  ],
                                ),
                              ],
                            ) :SizedBox.shrink();
                          }else{
                            return SizedBox.shrink();
                          }
                        }),

                    BlocListener<OrderBloc, OrderState>(
                      listenWhen: (prev,curr)=> curr is CreateOrderState || curr is RazorpayPaymentNotifyErrorOrderState,
                    listener: (context, state) {
                          if(state is CreateOrderState){
                            if(state.loading==true){
                              customLoader(context: context);
                            }
                            if(state.success==true  && state.loading==false){
                              context.pop();
                              context.pop();
                              customSnackBar(context, state.msg);
                            }else if (state.success==false && state.loading==false){
                              context.pop();
                              context.pop();
                              customSnackBar(context, state.msg);
                            }
                          }
                          if(state is RazorpayPaymentNotifyErrorOrderState){
                            context.pop();
                            customSnackBar(context, state.msg,bgColor: AppColors.red800);
                          }
                        },
                      child: Button(
                      onTap: (){
                        if(context.read<OrderBloc>().paymentMethod.trim().isEmpty || context.read<OrderBloc>().selectedAddress==null ){
                          context.read<OrderBloc>().add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: true));
                        }else{
                          context.read<OrderBloc>().add(IsPaymentMethodErrorVisibleEvent(isErrorVisible: false));
                          if(context.read<OrderBloc>().paymentMethod=='COD'){
                            context.read<OrderBloc>().add(CreateOrderOrderEvent(
                              items: context.read<OrderBloc>().items.map((item) => item.toJson()).toList(),
                              paymentMethod: context.read<OrderBloc>().paymentMethod,
                              totalAmount: context.read<OrderBloc>().totalPrice,
                              totalItems: context.read<OrderBloc>().items.length,
                              paymentId: "",
                              selectedAddress: context.read<OrderBloc>().selectedAddress!.toJson()
                            ));
                           }else{
                             context.read<OrderBloc>().add(RazorpayPaymentOrderEvent());
                           }

                        }

                      },
                      child: Center(child: Text(AppLocal.continueText.getString(context),style: AppTextStyles.medium18P(color: AppColors.white),)),
                    ),
),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
