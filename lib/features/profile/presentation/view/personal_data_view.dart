import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/custonConfirmationDialogBox.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/core/components/models/user_model.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/dialog_boxes/user_data_change_dialog.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/dialog_boxes/user_data_change_dialog_dropdown.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/personal_data_drop_down.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';
import 'package:speedy_chow/core/components/widgets/text_field_widget.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/user_image_view.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    userModel=context.read<ProfileBloc>().userModel; 
    if(userModel!=null){
      nameController.text= userModel?.name ?? "";
      dobController.text= getProperDate(userModel?.dob);
      genderController.text= userModel?.gender ?? "";
      phoneController.text= userModel?.phone.toString() ?? "";
      emailController.text= userModel?.email ?? "";
    }
  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dobController.dispose();
    genderController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ProfileItemAppBar(title: AppLocal.personalData.getString(context),) as PreferredSizeWidget,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: AppDimensions.spacing_24,
              top: AppDimensions.spacing_24,
              right: AppDimensions.spacing_24,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              UserImageView(),
              
              //user info
              BlocConsumer<ProfileBloc, ProfileState>(
                listenWhen: (prev,curr)=> curr is PersonalDataUpdateProfileState,
                listener: (context, state) {
                       if(state is PersonalDataUpdateProfileState){
                         if(state.loading==true){
                           customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
                         }else{
                           context.pop();
                           customSnackBar(context, state.msg);
                         }
                       }
                     },
                buildWhen: (prev,curr)=> curr is PersonalDataUpdateProfileState,
                builder: (context, state) {
                  if(state is PersonalDataUpdateProfileState){
                    if(state.success==true){
                      userModel=state.user;
                      nameController.text= userModel?.name ?? "";
                      dobController.text= getProperDate(userModel?.dob);
                      genderController.text= userModel?.gender ?? "";
                        phoneController.text= userModel?.phone.toString() ?? "";
                        emailController.text= userModel?.email ?? "";
                      return Column(
                        spacing: AppDimensions.spacing_10,
                        children: [
                          TextFieldWidget(
                            title: AppLocal.fullName.getString(context),
                            controller: nameController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(
                                context: context,
                                title: AppLocal.fullName.getString(context),
                                rightButtonTitle: AppLocal.change.getString(context),
                                leftOnPress: (){
                                  nameController.text=userModel?.name ?? "" ;
                                  context.pop();
                                },
                                rightOnPress: (){
                                  if(nameController.text.isNotEmpty){
                                    context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"name":nameController.text}, user: userModel!));
                                    context.pop();
                                  }else{
                                    customSnackBar(context, AppLocal.userNameRequired.getString(context));
                                  }
                                },
                                controller: nameController,);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            title: AppLocal.dateOfBirth.getString(context),
                            controller: dobController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(context: context,
                                  textFieldEnable: false,
                                  title: AppLocal.dateOfBirth.getString(context),
                                  rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    dobController.text=getProperDate(userModel?.dob);
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(dobController.text.isNotEmpty){
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"dob":dobController.text}, user: userModel!));
                                      context.pop();
                                    }else{
                                      customSnackBar(context, AppLocal.dobFieldEmpty.getString(context));
                                    }
                                  },
                                  controller: dobController);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            title: AppLocal.gender.getString(context),
                            controller: genderController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialogDropDown(context: context, title: AppLocal.gender.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                                leftOnPress: (){
                                  genderController.text=userModel?.gender ?? "" ;
                                  context.pop();
                                },
                                rightOnPress: (){
                                  if(genderController.text.isNotEmpty){
                                    context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"gender":genderController.text}, user: userModel!));
                                    context.pop();
                                  }else{
                                    customSnackBar(context, AppLocal.genderFieldEmpty.getString(context));
                                  }
                                },
                                controller: genderController,);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            keyboardType: TextInputType.number,
                            title: AppLocal.phone.getString(context),
                            controller: phoneController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(
                                  context: context,
                                  title: AppLocal.phone.getString(context),
                                  keyboardType: TextInputType.phone,
                                  rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    phoneController.text=userModel?.phone.toString() ?? "" ;
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(phoneController.text.isEmpty){
                                      customSnackBar(context, AppLocal.phoneNumberRequired.getString(context));
                                    }
                                    else if(phoneController.text.length!=10){
                                      customSnackBar(context, AppLocal.validPhoneNumber.getString(context));
                                    }else if(phoneController.text.length==10){
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"phone":phoneController.text}, user: userModel!));
                                      context.pop();
                                    }
                                  },
                                  controller: phoneController);
                            }, icon: Icon(Icons.edit)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: AppDimensions.spacing_8,
                              ),
                              child: Text("+91", style: AppTextStyles.medium14P()),
                            ),

                          ),

                          TextFieldWidget(
                            title: AppLocal.emailAddress.getString(context),
                            controller: emailController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(context: context, title: AppLocal.emailAddress.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    emailController.text=userModel?.email ?? "" ;
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(emailController.text.isEmpty){
                                      customSnackBar(context, AppLocal.emailRequired.getString(context),bgColor: AppColors.yellow800);
                                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text)){
                                      customSnackBar(context, AppLocal.validEmail.getString(context),bgColor: AppColors.yellow800);
                                    }else{
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"email":emailController.text}, user: userModel!));
                                      context.pop();
                                    }
                                  },
                                  controller: emailController);
                            }, icon: Icon(Icons.edit)),

                          ),
                        ],
                      );
                    }else{
                      return Column(
                        spacing: AppDimensions.spacing_10,
                        children: [
                          TextFieldWidget(
                            title: AppLocal.fullName.getString(context),
                            controller: nameController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(
                                context: context,
                                title: AppLocal.fullName.getString(context),
                                rightButtonTitle: AppLocal.change.getString(context),
                                leftOnPress: (){
                                  nameController.text=userModel?.name ?? "" ;
                                  context.pop();
                                },
                                rightOnPress: (){
                                  if(nameController.text.isNotEmpty){
                                    context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"name":nameController.text}, user: userModel!));
                                    context.pop();
                                  }else{
                                    customSnackBar(context, AppLocal.userNameRequired.getString(context));
                                  }
                                },
                                controller: nameController,);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            title: AppLocal.dateOfBirth.getString(context),
                            controller: dobController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(context: context,
                                  textFieldEnable: false,
                                  title: AppLocal.dateOfBirth.getString(context),
                                  rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    dobController.text= getProperDate(userModel?.dob);
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(dobController.text.isNotEmpty){
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"dob":dobController.text}, user: userModel!));
                                      context.pop();
                                    }else{
                                      customSnackBar(context, AppLocal.dobFieldEmpty.getString(context));
                                    }
                                  },
                                  controller: dobController);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            title: AppLocal.gender.getString(context),
                            controller: genderController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialogDropDown(context: context, title: AppLocal.gender.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                                leftOnPress: (){
                                  genderController.text=userModel?.gender ?? "" ;
                                  context.pop();
                                },
                                rightOnPress: (){
                                  if(genderController.text.isNotEmpty){
                                    context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"gender":genderController.text}, user: userModel!));
                                    context.pop();
                                  }else{
                                    customSnackBar(context, AppLocal.genderFieldEmpty.getString(context));
                                  }
                                },
                                controller: genderController,);
                            }, icon: Icon(Icons.edit)),
                          ),

                          TextFieldWidget(
                            keyboardType: TextInputType.number,
                            title: AppLocal.phone.getString(context),
                            controller: phoneController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(
                                  context: context,
                                  title: AppLocal.phone.getString(context),
                                  keyboardType: TextInputType.phone,
                                  rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    phoneController.text=userModel?.phone.toString() ?? "" ;
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(phoneController.text.isEmpty){
                                      customSnackBar(context, AppLocal.phoneNumberRequired.getString(context));
                                    }
                                    else if(phoneController.text.length!=10){
                                      customSnackBar(context, AppLocal.validPhoneNumber.getString(context));
                                    }else if(phoneController.text.length==10){
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"phone":phoneController.text}, user: userModel!));
                                      context.pop();
                                    }
                                  },
                                  controller: phoneController);
                            }, icon: Icon(Icons.edit)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: AppDimensions.spacing_8,
                              ),
                              child: Text("+91", style: AppTextStyles.medium14P()),
                            ),

                          ),

                          TextFieldWidget(
                            title: AppLocal.emailAddress.getString(context),
                            controller: emailController,
                            suffixIcon: IconButton(onPressed: (){
                              userDataChangeDialog(context: context, title: AppLocal.emailAddress.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                                  leftOnPress: (){
                                    emailController.text=userModel?.email ?? "" ;
                                    context.pop();
                                  },
                                  rightOnPress: (){
                                    if(emailController.text.isEmpty){
                                      customSnackBar(context, AppLocal.emailRequired.getString(context),bgColor: AppColors.yellow800);
                                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text)){
                                      customSnackBar(context, AppLocal.validEmail.getString(context),bgColor: AppColors.yellow800);
                                    }else{
                                      context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"email":emailController.text}, user: userModel!));
                                      context.pop();
                                    }
                                  },
                                  controller: emailController);
                            }, icon: Icon(Icons.edit)),

                          ),
                        ],
                      );
                    }
                  }
                return Column(
                spacing: AppDimensions.spacing_10,
                children: [
                  TextFieldWidget(
                    title: AppLocal.fullName.getString(context),
                    controller: nameController,
                    suffixIcon: IconButton(onPressed: (){
                      userDataChangeDialog(context: context, title: AppLocal.fullName.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                        leftOnPress: (){
                          nameController.text=userModel?.name ?? "" ;
                          context.pop();
                        },
                        rightOnPress: (){
                            if(nameController.text.isNotEmpty){
                              context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"name":nameController.text}, user: userModel!));
                              context.pop();
                            }else{
                              customSnackBar(context, AppLocal.userNameRequired.getString(context));
                            }
                      },
                        controller: nameController,);
                    }, icon: Icon(Icons.edit)),
                  ),

                  TextFieldWidget(
                    title: AppLocal.dateOfBirth.getString(context),
                    controller: dobController,
                    suffixIcon: IconButton(onPressed: (){
                         userDataChangeDialog(context: context,
                          textFieldEnable: false,
                          title: AppLocal.dateOfBirth.getString(context),
                          rightButtonTitle: AppLocal.change.getString(context),
                          leftOnPress: (){
                            dobController.text=getProperDate(userModel?.dob);
                            context.pop();
                             },
                          rightOnPress: (){
                            if(dobController.text.isNotEmpty){
                              context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"dob":dobController.text}, user: userModel!));
                              context.pop();
                            }else{
                              customSnackBar(context, AppLocal.dobFieldEmpty.getString(context));
                            }
                          },
                          controller: dobController);
                    }, icon: Icon(Icons.edit)),
                  ),

                  TextFieldWidget(
                    title: AppLocal.gender.getString(context),
                    controller: genderController,
                    suffixIcon: IconButton(onPressed: (){
                      userDataChangeDialogDropDown(context: context, title: AppLocal.gender.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                        leftOnPress: (){
                          genderController.text=userModel?.gender ?? "" ;
                          context.pop();
                        },
                        rightOnPress: (){
                          if(dobController.text.isNotEmpty){
                            context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"gender":genderController.text}, user: userModel!));
                            context.pop();
                          }else{
                            customSnackBar(context, AppLocal.dobFieldEmpty.getString(context));
                          }
                        },
                        controller: genderController,);
                    }, icon: Icon(Icons.edit)),
                  ),

                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    title: AppLocal.phone.getString(context),
                    controller: phoneController,
                    suffixIcon: IconButton(onPressed: (){
                      userDataChangeDialog(
                          context: context,
                          title: AppLocal.phone.getString(context),
                          keyboardType: TextInputType.phone,
                          rightButtonTitle: AppLocal.change.getString(context),
                          leftOnPress: (){
                            phoneController.text=userModel?.phone.toString() ?? "" ;
                            context.pop();
                          },
                          rightOnPress: (){
                            if(phoneController.text.isEmpty){
                               customSnackBar(context, AppLocal.phoneNumberRequired.getString(context));
                            }
                            else if(phoneController.text.length!=10){
                              customSnackBar(context, AppLocal.validPhoneNumber.getString(context));
                            }else if(phoneController.text.length==10){
                                context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"phone":phoneController.text}, user: userModel!));
                                context.pop();
                            }
                          },
                          controller: phoneController);
                    }, icon: Icon(Icons.edit)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: AppDimensions.spacing_8,
                      ),
                      child: Text("+91", style: AppTextStyles.medium14P()),
                    ),

                  ),

                  TextFieldWidget(
                    title: AppLocal.emailAddress.getString(context),
                    controller: emailController,
                    suffixIcon: IconButton(onPressed: (){
                      userDataChangeDialog(context: context, title: AppLocal.emailAddress.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                          leftOnPress: (){
                           emailController.text=userModel?.email ?? "" ;
                           context.pop();
                          },
                          rightOnPress: (){
                            if(emailController.text.isEmpty){
                              customSnackBar(context, AppLocal.emailRequired.getString(context),bgColor: AppColors.yellow800);
                            }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text)){
                              customSnackBar(context, AppLocal.validEmail.getString(context),bgColor: AppColors.yellow800);
                            }else{
                              context.read<ProfileBloc>().add(PersonalDataUpdateProfileEvent(data: {"email":emailController.text}, user: userModel!));
                              context.pop();
                            }

                          },
                          controller: emailController);
                    }, icon: Icon(Icons.edit)),

                  ),
                ],
              );
  },
             ),
            ],
          ),
        ),
      ),
    );
  }
}