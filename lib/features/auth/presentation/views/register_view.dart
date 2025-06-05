import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/text_field_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocal.registerTitle.getString(context),
              style: AppTextStyles.semiBold30P(),
            ),
            Text(
              AppLocal.registerSubTitle.getString(context),
              style: AppTextStyles.medium14P(color: AppColors.grey500),
            ),
            const SizedBox(height: AppDimensions.spacing_22),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppDimensions.spacing_20,
                children: [
                  TextFieldWidget(
                    controller: userNameController,
                    onValidate: (val) {
                      if (val!.isEmpty) {
                        return AppLocal.userNameRequired.getString(context);
                      }
                      return null;
                    },
                    label: AppLocal.userName.getString(context),
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    onValidate: (val) {
                      if (val!.isEmpty) {
                        return AppLocal.emailRequired.getString(context);
                      } else if (!val.contains("@")) {
                        return AppLocal.validEmail.getString(context);
                      }
                      return null;
                    },
                    label: AppLocal.emailAddress.getString(context),
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
                          controller: passwordController,
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.validPassword.getString(context);
                            }
                            return null;
                          },
                          label: AppLocal.password.getString(context),
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
                          controller: passwordController,
                          onValidate: (val) {
                            if (val!.isEmpty) {
                              return AppLocal.validPassword.getString(context);
                            }
                            return null;
                          },
                          label: AppLocal.password.getString(context),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimensions.spacing_10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: AppDimensions.spacing_5,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (prev,curr) => curr is AuthPolicyState,
                      builder: (context, state) {
                        if(state is AuthPolicyState){
                          return Checkbox(
                            value: state.isAgree,
                            side: BorderSide(width: AppDimensions.size_1),
                            onChanged: (val) {
                              context.read<AuthBloc>().add(AuthPolicyEvent(isAgree: !state.isAgree));
                            },
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity(
                              horizontal: -4.0,
                              vertical: 4.0,
                            ),
                          );
                        }else{
                          return Checkbox(
                            value: false,
                            side: BorderSide(width: AppDimensions.size_1),
                            onChanged: (val) {
                              context.read<AuthBloc>().add(AuthPolicyEvent(isAgree: false));
                            },
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity(
                              horizontal: -4.0,
                              vertical: 4.0,
                            ),
                          );
                        }

                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.medium14P(color: AppColors.text),

                          children: [
                            TextSpan(
                              text: AppLocal.agreeWithTAndS.getString(context),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: AppDimensions.spacing_3),
                            ),
                            TextSpan(
                              text: AppLocal.termsAndService.getString(context),
                              style: TextStyle(color: AppColors.darkOrange),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            WidgetSpan(
                              child: SizedBox(width: AppDimensions.spacing_3),
                            ),
                            TextSpan(text: AppLocal.and.getString(context)),
                            WidgetSpan(
                              child: SizedBox(width: AppDimensions.spacing_3),
                            ),
                            TextSpan(
                              text: AppLocal.privacyPolicy.getString(context),
                              style: TextStyle(color: AppColors.darkOrange),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listenWhen: (prev,curr) => curr is AuthRegisterState,
                  listener: (context, state) {
                    if (state is AuthRegisterState) {
                      if(!state.isAgree && !state.isLoading){
                        customSnackBar(
                          context,
                          AppLocal.acceptPolicy.getString(context),bgColor: AppColors.red800,
                        );
                      }
                      else if (state.isSuccess) {
                        customSnackBar(
                          context,
                          AppLocal.registerSuccess.getString(context),
                        );
                      }
                      else if (!state.isSuccess && !state.isLoading) {
                        customSnackBar(
                          context,
                          AppLocal.swtwr.getString(context),
                          bgColor: AppColors.errorRed.withValues(alpha: 0.9),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthRegisterState) {
                      return Button(
                        onTap: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()  ) {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        child: state.isLoading
                            ? Center(child: Loader())
                            : Text(
                                AppLocal.register.getString(context),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.medium20P(
                                  color: AppColors.white,
                                ),
                              ),
                      );
                    } else {
                      return Button(
                        onTap: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        child: Text(
                          AppLocal.register.getString(context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium20P(
                            color: AppColors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listenWhen: (prev, curr) => curr is AuthOpenLoginViewState,
                  listener: (context, state) {
                    context.goNamed(AppRoutes.login);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.medium14P(),
                        children: [
                          TextSpan(
                            text: AppLocal.alreadyAccount.getString(context),
                          ),
                          WidgetSpan(
                            child: SizedBox(width: AppDimensions.spacing_4),
                          ),
                          TextSpan(
                            style: TextStyle(color: AppColors.darkOrange),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<AuthBloc>().add(
                                  AuthOpenLoginViewEvent(),
                                );
                              },
                            text: AppLocal.login.getString(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
