import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: context.read<AuthBloc>().userModel!.image == null ? Text("A",style: AppTextStyles.medium30P(color: AppColors.white),)
          :Text("A",style: AppTextStyles.medium30P(color: AppColors.white),)
    );
  }
}
