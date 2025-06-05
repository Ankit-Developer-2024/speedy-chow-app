import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';

class OtpSheet extends StatelessWidget {
  OtpSheet({super.key});

  final List<TextEditingController> _controller = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  void _onChanged(int index, String val) {
    if (val.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (val.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_8,
            children: [
              IconButton.filledTonal(
                color: AppColors.black,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.white),
                ),
                onPressed: () {},
                icon: Icon(Icons.close_sharp),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(AppDimensions.spacing_24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radius_16),
                    topRight: Radius.circular(AppDimensions.radius_16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.spacing_8,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppLocal.otp.getString(context),
                        style: AppTextStyles.semiBold24P(),
                      ),
                    ),
                    Text(
                      AppLocal.emailVerification.getString(context),
                      style: AppTextStyles.semiBold30P(),
                    ),
                    Text(
                      AppLocal.emailVerificationSubTitle.getString(context),
                      style: AppTextStyles.medium14P(color: AppColors.grey500),
                    ),
                    Text(
                      context.read<AuthBloc>().email,
                      style: AppTextStyles.medium14P(color: AppColors.grey500),
                    ),
                    SizedBox(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.15,
                            height: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _controller[index],
                              focusNode: _focusNodes[index],
                              onChanged: (val) {
                                _onChanged(index, val);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.lock_clock),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              //resend otp
                              return Text(DateTime.now().second.toString());
                            },
                          ),
                        ],
                      ),
                    ),

                    Button(
                      onTap: () {
                        // if (_formKey.currentState != null &&
                        //     _formKey.currentState!.validate()) {
                        //   FocusScope.of(context).unfocus();
                        //   context.read<AuthBloc>().add(AuthEmailForgotPasswordEvent(email: emailController.text));
                        // }
                      },
                      child: Text(
                        AppLocal.continueText.getString(context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium20P(color: AppColors.white),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.medium14P(),
                          children: [
                            TextSpan(
                              text: AppLocal.doNotReceive.getString(context),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: AppDimensions.spacing_4),
                            ),
                            TextSpan(
                              style: TextStyle(color: AppColors.darkOrange),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: AppLocal.resend.getString(context),
                            ),
                          ],
                        ),
                      ),
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
