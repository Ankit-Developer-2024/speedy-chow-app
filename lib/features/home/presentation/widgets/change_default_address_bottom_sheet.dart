import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart';
import 'package:speedy_chow/features/home/presentation/widgets/address_auth_bottom_sheet.dart';

Future<dynamic> changeDefaultAddressBottomSheet(BuildContext context,
    {AddressModel? address}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: CustomChangeDefaultAddressBottomSheet(),
      );
    },
  );
}

class CustomChangeDefaultAddressBottomSheet extends StatefulWidget {
  const CustomChangeDefaultAddressBottomSheet({super.key});
  @override
  State<CustomChangeDefaultAddressBottomSheet> createState() =>
      _CustomChangeDefaultAddressBottomSheet();
}

class _CustomChangeDefaultAddressBottomSheet
    extends State<CustomChangeDefaultAddressBottomSheet> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.spacing_10,
                  children: [
                    Text(
                      AppLocal.chooseYourLocation.getString(context),
                      style: AppTextStyles.semiBold20P(),
                    ),
                    Text(
                      "${AppLocal.allAddresses.getString(context)} (${context.read<AuthBloc>().userModel?.addresses?.length.toString()})",
                      style: AppTextStyles.medium16P(),
                    ),
                      SizedBox(
                        height: 192,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              buildWhen: (prev,curr)=> curr is SelectDefaultAddressAuthState,
                              builder: (context, state) {
                                return BlocBuilder<AuthBloc, AuthState>(
                                buildWhen: (prev,curr)=>curr is SelectDefaultAddressAuthState,
                                builder: (context, state) {
                                  if(state is SelectDefaultAddressAuthState){
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: context
                                          .read<AuthBloc>()
                                          .userModel
                                      !.addresses
                                      !.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        AddressModel? address = context
                                            .read<AuthBloc>()
                                            .userModel!
                                            .addresses?[index];
                                        AddressModel? selectedAddress =
                                            context.read<AuthBloc>().defaultAddress;
                                        return InkWell(
                                          onTap: (){
                                           state.isLoading ? null : context.read<AuthBloc>().add(SelectDefaultAddressAuthEvent(data: address.toJson(), id: address.id.toString(),showAnimationIndex: index));
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             state.showAnimationIndex ==index ? CustomAnimationBuilder(
                                                tween: Tween(begin: 0,end:MediaQuery.sizeOf(context).width/2 ),
                                                duration: Duration(seconds: 1),
                                                control:state.isLoading ? Control.loop : Control.stop,
                                                builder:(context,value,_) =>  Container(
                                                  width: state.isLoading ? value.toDouble() : 0,
                                                  height: state.isLoading ? 5 : 0,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkOrange,
                                                      borderRadius: BorderRadius.circular(AppDimensions.radius_100)
                                                  ),
                                                ),
                                              ) : SizedBox.shrink(),
                                              Container(
                                                width: MediaQuery.sizeOf(context).width/2,
                                                height:187,
                                                padding:
                                                EdgeInsets.all(AppDimensions.spacing_10),
                                                decoration: BoxDecoration(
                                                    color: address == selectedAddress
                                                        ? AppColors.darkOrange.withAlpha(20)
                                                        : null,
                                                    borderRadius: BorderRadius.circular(
                                                        AppDimensions.radius_8),
                                                    border: BoxBorder.all(color: address == selectedAddress ? AppColors.darkOrange  : AppColors.grey500)
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  spacing: AppDimensions.spacing_1,
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
                                                      maxLines: 5,
                                                      overFlow: TextOverflow.ellipsis,
                                                    ),
                                                    address == selectedAddress ? Text(AppLocal.defaultAddress.getString(context),style: AppTextStyles.regular16P(),) : Text(""),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context,index){
                                        return SizedBox(width: AppDimensions.spacing_8,);
                                      },
                                    );
                                  }else{
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: context
                                          .read<AuthBloc>()
                                          .userModel
                                      !.addresses
                                      !.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        AddressModel? address = context
                                            .read<AuthBloc>()
                                            .userModel!
                                            .addresses?[index];
                                        AddressModel? selectedAddress =
                                            context.read<AuthBloc>().defaultAddress;
                                        return InkWell(
                                          onTap: (){

                                            context.read<AuthBloc>().add(SelectDefaultAddressAuthEvent(data: address.toJson(), id: address.id.toString(),showAnimationIndex: index));
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context).width/2,
                                            padding:
                                            EdgeInsets.all(AppDimensions.spacing_10),
                                            decoration: BoxDecoration(
                                                color: address == selectedAddress
                                                    ? AppColors.darkOrange.withAlpha(20)
                                                    : null,
                                                borderRadius: BorderRadius.circular(
                                                    AppDimensions.radius_8),
                                                border: BoxBorder.all(color: address == selectedAddress ? AppColors.darkOrange  : AppColors.grey500)
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              spacing: AppDimensions.spacing_1,
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
                                                  maxLines: 5,
                                                  overFlow: TextOverflow.ellipsis,
                                                ),
                                                address == selectedAddress ? Text(AppLocal.defaultAddress.getString(context),style: AppTextStyles.regular16P(),) : Text(""),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context,index){
                                        return SizedBox(width: AppDimensions.spacing_8,);
                                      },
                                    );
                                  }

                          },
                        );
                              },
                            ),
                            SizedBox(width: AppDimensions.spacing_8,),
                            InkWell(
                              onTap: (){
                                addressAuthBottomSheet(context);
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width/2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radius_8),
                                    border: BoxBorder.all(color: AppColors.grey500)
                                ),
                                child: Center(child: Text(AppLocal.addAddressOrPickUpPoint.getString(context), textAlign: TextAlign.center ,style: AppTextStyles.medium16P(),)),
                              ),
                            )
                          ],
                        ),
                      ),

                  ],
                ),
              )
            ]),
      ),
    );
  }
}
