import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/widgets/otp_sheet.dart';

Future<dynamic> otpBottomSheet(BuildContext context,AuthBloc authBloc) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: authBloc,
        child: OtpSheet(snackBarContext: context,),
      );
    },
  );
}
