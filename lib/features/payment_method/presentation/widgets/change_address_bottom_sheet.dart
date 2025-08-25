import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/address_bottom_sheet.dart';
import 'package:speedy_chow/features/payment_method/presentation/widgets/get_address.dart';

Future<dynamic> changeAddressBottomSheet(BuildContext context,{AddressModel? address}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<PaymentMethodBloc>(),
        child: CustomChangeAddressBottomSheet(address: address,),
      );
    },
  );
}

class CustomChangeAddressBottomSheet extends StatefulWidget {
  const CustomChangeAddressBottomSheet({super.key,this.address});
  final AddressModel? address;
  @override
  State<CustomChangeAddressBottomSheet> createState() => _CustomChangeAddressBottomSheet();
}

class _CustomChangeAddressBottomSheet extends State<CustomChangeAddressBottomSheet> {


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_10,
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
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(AppDimensions.spacing_24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radius_16),
                    topRight: Radius.circular(AppDimensions.radius_16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.spacing_10,
                  children: [
                    Text(AppLocal.selectDeliveryAddress.getString(context),style: AppTextStyles.semiBold20P(),),
                    Text("${AppLocal.allAddresses.getString(context)} (${context.read<PaymentMethodBloc>().userModel?.addresses?.length.toString()})",style: AppTextStyles.medium16P(),),
                    BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                      buildWhen: (prev,curr)=> curr is SelectDeliveryAddressState,
                      builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: context.read<PaymentMethodBloc>().userModel?.addresses?.length,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          Address? address=context.read<PaymentMethodBloc>().userModel!.addresses?[index];
                          Address? selectedAddress=context.read<PaymentMethodBloc>().addressModel;
                        return Container(
                          padding: EdgeInsets.all(AppDimensions.spacing_14),
                          decoration: BoxDecoration(
                            color: address==selectedAddress ? AppColors.grey100 : null,
                            borderRadius: BorderRadius.circular(AppDimensions.radius_8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: AppDimensions.spacing_8,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: AppDimensions.spacing_6),
                                child: InkWell(
                                   onTap: (){
                                       context.read<PaymentMethodBloc>().add(SelectDeliveryAddressEvent(address: address!));
                                   },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: AppDimensions.size_24,
                                        height: AppDimensions.size_24,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                                          color: address==selectedAddress ? AppColors.darkOrange : null,
                                          border: address==selectedAddress ? null : Border.all(color: AppColors.black_5)
                                        ),

                                      ),
                                      Container(
                                        width: AppDimensions.size_10,
                                        height: AppDimensions.size_10,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppDimensions.spacing_3,
                                  children: [
                                    Text(context.read<PaymentMethodBloc>().userModel!.name.toString(),style: AppTextStyles.semiBold14P(),),
                                    GetAddress(address: address!,textStyle: AppTextStyles.regular16P(),),
                                    Text("Phone Number: ${context.read<PaymentMethodBloc>().userModel!.phone.toString()}",style:AppTextStyles.regular16P(),),
                                    address==selectedAddress ? SizedBox(height: AppDimensions.spacing_8,) : SizedBox.shrink(),
                                    address==selectedAddress ? Button(
                                       onTap: (){
                                       context.pop();
                                     },
                                        color:AppColors.yellow900,
                                        child: Center(child: Text(AppLocal.deliverAddress.getString(context),style: AppTextStyles.medium16P(),),))  : SizedBox.shrink(),
                                    address==selectedAddress ? SizedBox(height: AppDimensions.spacing_8,) : SizedBox.shrink(),
                                    address==selectedAddress ? Button(
                                        onTap: (){
                                          addressBottomSheet(context,address: address);
                                        },
                                        color:AppColors.white,
                                        child: Center(child: Text(AppLocal.editAddress.getString(context),style: AppTextStyles.medium16P(),),))  : SizedBox.shrink(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                    });
  },
),
                    Container(
                      height: AppDimensions.size_2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius_100,
                        ),
                        color: AppColors.grey50,
                      ),
                    ),
                    Text(AppLocal.addNewDeliveryAddress.getString(context),style: AppTextStyles.medium16P(),),
                    Button(
                        onTap: (){
                          addressBottomSheet(context);
                        },
                        color: AppColors.white,
                        border: Border.all(color: AppColors.grey500),
                        child: Center(child: Text(AppLocal.addAddress.getString(context),style: AppTextStyles.medium16P(),),)),
                    Row(
                      spacing: AppDimensions.spacing_8,
                      children: [
                        Expanded(
                          child: Container(
                            height: AppDimensions.size_2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius_100,
                              ),
                              color: AppColors.grey50,
                            ),
                          ),
                        ),
                        Text(AppLocal.or.getString(context),style: AppTextStyles.medium16P(),),
                        Expanded(
                          child: Container(
                            height: AppDimensions.size_2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius_100,
                              ),
                              color: AppColors.grey50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: (){
                        context.pop();
                      }, child: Text("Back to cart",style: AppTextStyles.medium14P(color: AppColors.darkOrange),),),
                    )




                  ],
                ),
              )
            ]
        ),
      ),
    );
  }
}

