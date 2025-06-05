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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
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
          spacing: AppDimensions.spacing_8,
          children: [
            Text(
              AppLocal.loginTitle.getString(context),
              style: AppTextStyles.semiBold30P(),
            ),
            Text(
              AppLocal.loginSubTitle.getString(context),
              style: AppTextStyles.medium14P(color: AppColors.grey500),
            ),
            const SizedBox(height: AppDimensions.spacing_12),
            Form(
              key: _formKey,
              child: Column(
                spacing: AppDimensions.spacing_20,
                children: [
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
                              return AppLocal.validPassword.getString(
                                context,
                              );
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
                              return AppLocal.validPassword.getString(
                                context,
                              );
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
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppDimensions.spacing_10,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: WidgetStateProperty.all(
                      EdgeInsets.all(AppDimensions.spacing_2),
                    ),
                  ),
                  child: Text(
                    AppLocal.forgotPassword.getString(context),
                    textAlign: TextAlign.end,
                    style: AppTextStyles.medium14P(
                      color: AppColors.darkOrange,
                    ),
                  ),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listenWhen: (prev, curr) => curr is AuthLoginState,
                  listener: (context, state) {
                    if (state is AuthLoginState) {
                      if (state.isSuccess && !state.isLoading) {
                        customSnackBar(
                          context,
                          AppLocal.loginSuccess.getString(context),
                        );
                        context.goNamed(AppRoutes.register);
                      } else if (!state.isSuccess && !state.isLoading) {
                        customSnackBar(
                          context,
                          AppLocal.loginFailed.getString(context),
                          bgColor: AppColors.red800,
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoginState) {
                      return Button(
                        onTap: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        child: state.isLoading
                            ? Center(child: Loader())
                            : Text(
                                AppLocal.login.getString(context),
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
                              AuthLoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        child: Text(
                          AppLocal.login.getString(context),
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
                  listenWhen: (prev,curr)=> curr is AuthOpenRegisterViewState,
                  listener: (context, state) {
                     context.goNamed(AppRoutes.register);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.medium14P(),
                      children: [
                        TextSpan(
                          text: AppLocal.doNotAccount.getString(context),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: AppDimensions.spacing_4),
                        ),
                        TextSpan(
                          style: TextStyle(color: AppColors.darkOrange),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            context.read<AuthBloc>().add(AuthOpenRegisterViewEvent());
                          },
                          text: AppLocal.register.getString(context),
                        ),
                      ],
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
