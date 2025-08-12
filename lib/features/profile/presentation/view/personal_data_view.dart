import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/custonConfirmationDialogBox.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/data/models/user_model.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/dialog_boxes/user_data_change_dialog.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/personal_data_drop_down.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/text_field_widget.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    userModel=context.read<AuthBloc>().userModel;
    if(userModel!=null){
      nameController.text= userModel?.name ?? "";
      dobController.text= userModel?.dob ?? "";
      genderController.text= userModel?.gender ?? "";
      phoneController.text= userModel?.phone ?? "";
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
              Form(
                key: _formKey,
                child: Column(
                  spacing: AppDimensions.spacing_10,
                  children: [
                    TextFieldWidget(
                      title: AppLocal.fullName.getString(context),
                      controller: nameController,
                      suffixIcon: IconButton(onPressed: (){
                        userDataChangeDialog(context: context, title: AppLocal.fullName.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                          rightOnPress: (){
                              if(nameController.text.isNotEmpty){
                                //call api here
                              }
                        },
                          controller: nameController,);
                      }, icon: Icon(Icons.edit)),

                    ),
                    BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) async {
                        if (state is ProfileDataOpenDatePickerState) {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          dobController.text =
                              "${selectedDate!.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}";
                        }
                      },
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius_8,
                        ),
                        onTap: () {
                          context.read<ProfileBloc>().add(
                            ProfileDataOpenDatePickerEvent(),
                          );
                        },
                        child: TextFieldWidget(
                          enabled: false,
                          title: AppLocal.dateOfBirth.getString(context),
                          controller: dobController,
                        ),
                      ),
                    ),
                    PersonalDataDropDown(
                      title: AppLocal.gender.getString(context),
                      controller: genderController,
                    ),
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      title: AppLocal.phone.getString(context),
                      controller: phoneController,
                      suffixIcon: IconButton(onPressed: (){
                        userDataChangeDialog(context: context, title: AppLocal.phone.getString(context), rightButtonTitle: AppLocal.change.getString(context),
                            rightOnPress: (){

                            },
                            controller: phoneController);
                      }, icon: Icon(Icons.edit)),
                      validator: (val){
                        if(val!.isEmpty){
                          return AppLocal.phoneNumberRequired.getString(context);
                        }
                        else if(val.length!=10){
                          return AppLocal.validPhoneNumber.getString(context);
                        }
                        return null;
                      },
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
                              }
                            },
                            controller: emailController);
                      }, icon: Icon(Icons.edit)),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}
