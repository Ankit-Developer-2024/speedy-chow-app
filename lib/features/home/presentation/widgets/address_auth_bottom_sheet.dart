import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/helpers/fetch_lat_log_helper.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/text_field_widget.dart';

Future<dynamic> addressAuthBottomSheet(BuildContext context) {
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
       child: CustomAddressAuthBottomSheet(),
);
    },
  );
}

class CustomAddressAuthBottomSheet extends StatefulWidget {
  const CustomAddressAuthBottomSheet({super.key});

  @override
  State<CustomAddressAuthBottomSheet> createState() => _CustomAddressAuthBottomSheetState();
}

class _CustomAddressAuthBottomSheetState extends State<CustomAddressAuthBottomSheet> {

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
    name.text = context.read<AuthBloc>().userModel!.name.toString();
    phone.text = context.read<AuthBloc>().userModel!.phone.toString();

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
                      Text(AppLocal.addNewDeliveryAddress.getString(context),style: AppTextStyles.semiBold20P(),),
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
                      BlocListener<AuthBloc, AuthState>(
                        listenWhen: (prev,curr)=> curr is UserFetchAddressAuthState,
                        listener: (context, states) {
                        if(states is UserFetchAddressAuthState){
                            if(states.loading==true){
                              customLoaderDialog(context: context, title:AppLocal.fetchingAddress.getString(context));
                            }
                            else if(states.loading==false && states.error==false){
                              street.text=states.street;
                              zipcode.text=states.zipcode;
                              country.text=states.country;
                              state.text=states.state;
                              city.text=states.city;
                              context.pop();
                            }else if(states.loading==false && states.error==true){
                              customSnackBar(context,states.message);
                            }
                           }
                        },
                        child: Button(onTap: (){
                          context.read<AuthBloc>().add(UserFetchAddressAuthEvent(context: context));
                          },
                          color: AppColors.transparent,
                          border: BoxBorder.fromBorderSide(BorderSide(color: AppColors.grey500)),
                          child: Center(child: Text(AppLocal.useMyLocation.getString(context),style: AppTextStyles.medium16P(),))
                      ),),

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
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (prev,curr)=>curr is FormIsDefaultAddressAuthState,
                       builder: (context, state) {
                          if(state is FormIsDefaultAddressAuthState){
                            return CheckboxMenuButton(
                                value: isDefault,
                                onChanged: (val){
                                  isDefault=!isDefault; 
                                  context.read<AuthBloc>().add(FormIsDefaultAddressAuthEvent());
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
                                  context.read<AuthBloc>().add(FormIsDefaultAddressAuthEvent());
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(EdgeInsets.all(5)),
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radius_8))),
                                ),
                                child: Text(AppLocal.makeDefaultAddress.getString(context),style: AppTextStyles.medium14P(),));
                          }

                         },
                      ),
                      BlocListener<AuthBloc, AuthState>(
                       listenWhen: (prev ,curr)=> curr is AddAddressAuthState,
                       listener: (context, state) {
                         if(state  is AddAddressAuthState){
                           if(state.isLoading==true){
                             customLoader(context: context);
                           }else if(state.isLoading==false){
                             context.pop();
                             context.pop();
                           }
                         }
                       },
                       child: Button(onTap: (){
                        if(key.currentState!.validate()){
                          context.read<AuthBloc>().add(AddAddressAuthEvent(
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
                          child: Center(child: Text(AppLocal.addAddress.getString(context),style: AppTextStyles.semiBold14P(color: AppColors.white),),)),
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

