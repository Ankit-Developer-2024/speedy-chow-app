import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/loader.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';

class OtpSheet extends StatefulWidget {
  const OtpSheet({super.key});

  @override
  State<OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<OtpSheet> {
  final List<TextEditingController> _controller = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  String otp = '';

  void _onChanged(int index, String val) {
    otp =
        _controller[0].text +
        _controller[1].text +
        _controller[2].text +
        _controller[3].text;
    if (otp.length == 4) {
      context.read<AuthBloc>().add(AuthIsOtpValidEvent(otp: otp));
    }

    if (val.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (val.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthStartOtpTimerEvent());
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
                onPressed: () {
                  context.pop();
                },
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
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.15,
                            height: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              //  maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
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
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: AppDimensions.spacing_8,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: AppDimensions.size_20,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (prev, curr) =>
                                curr is AuthTickOtpTimerState,
                            builder: (context, state) {
                              if (state is AuthTickOtpTimerState) {
                                return Text(
                                  state.otpSecondsRemaining.toString().padLeft(
                                    2,
                                    '0',
                                  ),
                                  style: AppTextStyles.medium14P(),
                                );
                              } else {
                                return Text(
                                  30.toString().padLeft(2, '0'),
                                  style: AppTextStyles.medium14P(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (pre, curr) => curr is AuthIsOtpValidState,
                      builder: (context, state) {
                        if (state is AuthIsOtpValidState) {
                          return !state.isSuccess && !state.isLoading
                              ? Text(
                                  AppLocal.inValidOtp.getString(context),
                                  style: AppTextStyles.medium14P(
                                    color: AppColors.errorRed,
                                  ),
                                )
                              : SizedBox.shrink();
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),

                    BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (prev, curr) => curr is AuthIsOtpValidState,
                      listener: (context, state) {
                        if (state is AuthIsOtpValidState) {
                          if (state.isSuccess && state.isLoading==false) {
                            context.pushNamed(AppRoutes.resetPassword);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthIsOtpValidState) {
                          return Button(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                AuthIsOtpValidEvent(otp: otp),
                              );
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
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                AuthIsOtpValidEvent(otp: otp),
                              );
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

                    Align(
                      alignment: Alignment.topCenter,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (prev, curr) =>
                            curr is AuthTickOtpTimerState,

                        builder: (context, state) {
                          if(state is AuthTickOtpTimerState){
                            return RichText(
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
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      state.canResendOtp ? context.read<AuthBloc>().add(AuthStartOtpTimerEvent()) : null;
                                    },
                                    text: AppLocal.resend.getString(context),
                                  ),
                                ],
                              ),
                            );
                          }else{
                            return RichText(
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
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      context.read<AuthBloc>().add(AuthStartOtpTimerEvent());
                                    },
                                    text: AppLocal.resend.getString(context),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
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
