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
import 'package:speedy_chow/features/auth/presentation/widgets/otp_bottomSheet.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/text_field_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            bottom: AppDimensions.spacing_24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.spacing_8,
          children: [
            Text(
              AppLocal.forgotPassword.getString(context),
              style: AppTextStyles.semiBold30P(),
            ),
            Text(
              AppLocal.forgotPasswordSubTitle.getString(context),
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
                ],
              ),
            ),
            Spacer(),
            BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (prev, curr) => curr is AuthEmailForgotPasswordState,
              listener: (context, state) {
                if (state is AuthEmailForgotPasswordState) {
                  if (state.isSuccess && !state.isLoading) {
                    otpBottomSheet(context,context.read<AuthBloc>());

                  } else if (!state.isSuccess && !state.isLoading) {
                    customSnackBar(
                      context,
                      AppLocal.loginFailed.getString(context),
                      bgColor: AppColors.red800,
                    );
                  }
                }
              },
              buildWhen: (prev, curr) => curr is AuthEmailForgotPasswordState,
              builder: (context, state) {
                if (state is AuthEmailForgotPasswordState) {
                  return Button(
                    onTap: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(AuthEmailForgotPasswordEvent(email: emailController.text));
                      }
                    },
                    child: state.isLoading
                        ? Center(child: Loader())
                        : Text(
                      AppLocal.continueText.getString(context),
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
                       context.read<AuthBloc>().add(AuthEmailForgotPasswordEvent(email: emailController.text));
                      }
                    },
                    child: Text(
                      AppLocal.continueText.getString(context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.medium20P(
                        color: AppColors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
