import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/password_changed_bottom_sheet.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/text_field_widget.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocal.resetPassword.getString(context),
          style: AppTextStyles.medium14P(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            bottom: AppDimensions.spacing_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.spacing_8,
          children: [
            Text(
              AppLocal.resetPassword.getString(context),
              style: AppTextStyles.semiBold30P(),
            ),
            Text(
              AppLocal.resetPasswordSubTitle.getString(context),
              style: AppTextStyles.medium14P(color: AppColors.grey500),
            ),
            const SizedBox(height: AppDimensions.spacing_12),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppDimensions.spacing_20,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is PasswordHiddenState) {
                        return TextFieldWidget(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              PasswordHiddenEvent(
                                isPassHidden: !state.isPassHidden,
                              ),
                            );
                          },
                          isObscureText: state.isPassHidden,
                          icon: state.isPassHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: newPasswordController,
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.validPassword.getString(
                                context,
                              );
                            }
                            return null;
                          },
                          label: AppLocal.newPassword.getString(context),
                        );
                      } else {
                        return TextFieldWidget(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              PasswordHiddenEvent(isPassHidden: false),
                            );
                          },
                          isObscureText: true,
                          icon: Icons.visibility_off,
                          controller: newPasswordController,
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.passwordRequired.getString(
                                context,
                              );
                            }else if(!RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$').hasMatch(val)) {
                              return AppLocal.passwordType.getString(context);
                            }
                            return null;
                          },
                          label: AppLocal.newPassword.getString(context),
                        );
                      }
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is PasswordHiddenState) {
                        return TextFieldWidget(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              PasswordHiddenEvent(
                                isPassHidden: !state.isPassHidden,
                              ),
                            );
                          },
                          isObscureText: state.isPassHidden,
                          icon: state.isPassHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: newPasswordConfirmController,
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.passwordRequired.getString(
                                context,
                              );
                            }
                            return null;
                          },
                          label: AppLocal.confirmPassword.getString(context),
                        );
                      } else {
                        return TextFieldWidget(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              PasswordHiddenEvent(isPassHidden: false),
                            );
                          },
                          isObscureText: true,
                          icon: Icons.visibility_off,
                          controller: newPasswordConfirmController,
                          onChange: (val){},
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.validPassword.getString(
                                context,
                              );
                            }
                            return null;
                          },
                          label: AppLocal.confirmPassword.getString(context),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (prev,curr)=>curr is AuthResetPasswordMatchState,
              builder: (context, state) {
                if(state is AuthResetPasswordMatchState){
                  return state.isMatch ? SizedBox.shrink()  : Text(AppLocal.passwordMatch.getString(context),
                    style: AppTextStyles.medium14P(color: AppColors.errorRed),);
                }
                return SizedBox.shrink();
              },
            ),
            Spacer(),
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (prev, curr) => curr is AuthResetPasswordState,
              listener: (context, state) {
                if (state is AuthResetPasswordState) {
                  if(state.isLoading==true){
                    customLoaderDialog(context: context, title: AppLocal.loading);
                  }
                  else if (state.isSuccess && !state.isLoading) {
                    context.pop();
                    passwordChangedBottomSheet(context);
                  } else if (!state.isSuccess && !state.isLoading) {
                    context.pop();
                    customSnackBar(
                      context,
                      state.msg,
                      bgColor: AppColors.red800,
                    );
                  }
                }
              },
              child: Button(
                onTap: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    context.read<AuthBloc>().add(AuthResetPasswordEvent(newPassword: newPasswordController.text, newConfirmPassword: newPasswordConfirmController.text));
                  }
                },
                child:Text(
                  AppLocal.continueText.getString(context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium20P(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
