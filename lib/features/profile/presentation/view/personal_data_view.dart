import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/personal_data_drop_down.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/text_field_widget.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/user_image_view.dart';

class PersonalDataView extends StatelessWidget {
  PersonalDataView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ProfileItemAppBar(title: AppLocal.personalData.getString(context),) as PreferredSizeWidget,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: AppDimensions.spacing_24,
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppLocal.userNameRequired.getString(context);
                        }
                        return null;
                      },
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
                      validator: (val){
                        if(val!.isEmpty){
                          return AppLocal.emailRequired.getString(context);
                        }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)){
                          return AppLocal.validEmail.getString(context);
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
      BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen:(prev,curr)=> curr is ProfilePersonalDataSaveState,
        listener: (context, state) {
          if(state is ProfilePersonalDataSaveState){

            state.isSuccess? customSnackBar(context, "Data Save Successfully") : null;
          }
        },
        buildWhen: (prev,curr)=> curr is ProfilePersonalDataSaveState,
        builder: (context, state) {
          if(state is ProfilePersonalDataSaveState){
            return Button(
              width: MediaQuery.sizeOf(context).width-40,
              height: AppDimensions.size_55,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  state.isLoading ? null : context.read<ProfileBloc>().add(
                    ProfilePersonalDataSaveEvent(
                      fullName: nameController.text,
                      dob: dobController.text,
                      gender: genderController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                    ),
                  );
                }
              },
              child: Center(
                child: state.isLoading ? Loader() :  Text(
                  AppLocal.save.getString(context),
                  style: AppTextStyles.medium16P(
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          }
          return Button(
            width: MediaQuery.sizeOf(context).width-40,
            height: AppDimensions.size_55,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<ProfileBloc>().add(
                  ProfilePersonalDataSaveEvent(
                    fullName: nameController.text,
                    dob: dobController.text,
                    gender: genderController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                  ),
                );
              }
            },
            child: Center(
              child: Text(
                AppLocal.save.getString(context),
                style: AppTextStyles.medium16P(
                  color: AppColors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
