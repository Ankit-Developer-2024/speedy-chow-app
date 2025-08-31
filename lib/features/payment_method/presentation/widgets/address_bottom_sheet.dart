import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/domain/enitites/address.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

Future<dynamic> addressBottomSheet(BuildContext context,{Address? address}) {
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
       child: CustomAddressBottomSheet(address: address,),
);
    },
  );
}

class CustomAddressBottomSheet extends StatefulWidget {
  const CustomAddressBottomSheet({super.key,this.address});
  final Address? address;
  @override
  State<CustomAddressBottomSheet> createState() => _CustomAddressBottomSheetState();
}

class _CustomAddressBottomSheetState extends State<CustomAddressBottomSheet> {

  GlobalKey<FormState> key= GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController houseNo=TextEditingController();
  TextEditingController street=TextEditingController();
  TextEditingController landMark=TextEditingController();
  TextEditingController zipcode=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController country=TextEditingController();
  bool isDefault=false;

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    phone.dispose();
    houseNo.dispose();
    street.dispose();
    landMark.dispose();
    zipcode.dispose();
    city.dispose();
    state.dispose();
    country.dispose();
  }

  @override
  Widget build(BuildContext context) {
    country.text="India";
    name.text = context.read<PaymentMethodBloc>().userModel!.name.toString();
    phone.text = context.read<PaymentMethodBloc>().userModel!.phone.toString();
    if(widget.address!=null){
        houseNo.text=widget.address!.houseNo.toString();
        street.text=widget.address!.street.toString();
        landMark.text=widget.address!.landMark.toString();
        zipcode.text=widget.address!.zipCode.toString();
        city.text=widget.address!.city.toString();
        state.text=widget.address!.state.toString();
        isDefault=widget.address!.isDefault ?? false;

    }
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
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.spacing_10,
                    children: [
                      Text(widget.address!=null ? AppLocal.editDeliveryAddress.getString(context) : AppLocal.addNewDeliveryAddress.getString(context),style: AppTextStyles.semiBold20P(),),
                      TextFieldWidget(controller: country,
                        label: AppLocal.country.getString(context),
                        onValidate: (val){
                          if(val!.isEmpty){
                            return AppLocal.countryRequired.getString(context);
                          }
                          return null;
                        },),
                      TextFieldWidget(controller: name, label: AppLocal.fullName.getString(context),
                        onValidate: (val){
                          if(val!.isEmpty){
                            return AppLocal.userNameRequired.getString(context);
                          }
                          return null;
                        },),
                      TextFieldWidget(controller: phone, label: AppLocal.phone.getString(context),
                          onValidate: (val){
                            if(val!.isEmpty){
                              return AppLocal.phoneNumberRequired.getString(context);
                            }
                            return null;
                          }
                      ),
                      Text(AppLocal.maybeAssistDelivery.getString(context),style: AppTextStyles.medium12P(),),
                      Button(onTap: (){},
                          color: AppColors.transparent,
                          border: BoxBorder.fromBorderSide(BorderSide(color: AppColors.grey500)),
                          child: Center(child: Text(AppLocal.useMyLocation.getString(context),style: AppTextStyles.medium16P(),))),
                      TextFieldWidget(controller: houseNo, label: AppLocal.houseNo.getString(context),
                          onValidate: (val){
                            if(val!.isEmpty){
                              return AppLocal.houseNoRequired.getString(context);
                            }
                            return null;
                          }
                      ),
                      TextFieldWidget(controller: street, label: AppLocal.street.getString(context),
                          onValidate: (val){
                            if(val!.isEmpty){
                              return AppLocal.streetRequired.getString(context);
                            }
                            return null;
                          }
                      ),
                      TextFieldWidget(controller: landMark, label: AppLocal.landmark.getString(context),
                          onValidate: (val){
                            if(val!.isEmpty){
                              return AppLocal.landmarkRequired.getString(context);
                            }
                            return null;
                          }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width/2 - AppDimensions.spacing_30,
                              child: TextFieldWidget(controller: zipcode,
                                  label: AppLocal.zipcode.getString(context),
                                  onValidate: (val){
                                    if(val!.isEmpty){
                                      return AppLocal.zipcodeRequired.getString(context);
                                    }
                                    return null;
                                  }
                              )),
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width/2 - AppDimensions.spacing_30,
                              child: TextFieldWidget(controller: city,
                                  label: AppLocal.city.getString(context),
                                  onValidate: (val){
                                    if(val!.isEmpty){
                                      return AppLocal.cityRequired.getString(context);
                                    }
                                    return null;
                                  }
                              )),
                        ],
                      ),
                      TextFieldWidget(controller: state, label: AppLocal.state.getString(context),
                          onValidate: (val){
                            if(val!.isEmpty){
                              return AppLocal.stateRequired.getString(context);
                            }
                            return null;
                          }
                      ),
                      BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                        buildWhen: (prev,curr)=>curr is DefaultAddressState,
                       builder: (context, state) {
                          if(state is DefaultAddressState){
                            return CheckboxMenuButton(
                                value: isDefault,
                                onChanged: (val){
                                  isDefault=!isDefault; 
                                  context.read<PaymentMethodBloc>().add(DefaultAddressEvent());
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(EdgeInsets.all(5)),
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radius_8))),
                                ),
                                child: Text(AppLocal.makeDefaultAddress.getString(context),style: AppTextStyles.medium14P(),));
                          }else{
                            return CheckboxMenuButton(
                                value: isDefault,
                                onChanged: (val){
                                  isDefault=!isDefault;
                                  context.read<PaymentMethodBloc>().add(DefaultAddressEvent());
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(EdgeInsets.all(5)),
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radius_8))),
                                ),
                                child: Text(AppLocal.makeDefaultAddress.getString(context),style: AppTextStyles.medium14P(),));
                          }

                         },
                      ),
                      BlocListener<PaymentMethodBloc, PaymentMethodState>(
                       listenWhen: (prev ,curr)=> curr is AddressPaymentMethodState,
                       listener: (context, state) {
                         if(state  is AddressPaymentMethodState){
                           if(state.loading==true){
                             customLoader(context: context);
                           }else if(state.loading==false){
                             context.pop();
                             context.pop();
                           }
                         }
                       },
                       child: Button(onTap: (){
                        if(key.currentState!.validate()){
                          widget.address!=null ?
                              context.read<PaymentMethodBloc>().add(UpdateAddressPaymentMethodEvent(
                                  data: {
                                    "addresses":{
                                      "houseNo":houseNo.text,
                                      "street":street.text,
                                      "city": city.text,
                                      "landMark":landMark.text,
                                      "zipCode":zipcode.text,
                                      "state":state.text,
                                      "country":country.text,
                                      "isDefault":isDefault
                                    }
                                  },
                                  user: context.read<PaymentMethodBloc>().userModel!,
                                  id: widget.address!.id!
                              ))
                              : context.read<PaymentMethodBloc>().add(AddAddressPaymentMethodEvent(
                              user: context.read<PaymentMethodBloc>().userModel!,
                              data: {
                                "addresses":{
                                  "houseNo":houseNo.text,
                                  "street":street.text,
                                  "city": city.text,
                                  "landMark":landMark.text,
                                  "zipCode":zipcode.text,
                                  "state":state.text,
                                  "country":country.text,
                                  "isDefault":isDefault
                                }
                              }));
                        }
                      },
                          child: Center(child: Text(widget.address!=null ? AppLocal.updateAddress.getString(context) : AppLocal.addAddress.getString(context),style: AppTextStyles.semiBold14P(color: AppColors.white),),)),
)

                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}

