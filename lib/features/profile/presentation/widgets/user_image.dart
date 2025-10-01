import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key,this.textStyle});
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return context.read<ProfileBloc>().userModel?.name!=null ?
    Text(
     context.read<ProfileBloc>().userModel!.name!.trim().substring(0,1).toUpperCase()
    ,style: textStyle ?? AppTextStyles.medium30P(color: AppColors.white),)
     : SvgPicture.asset(
      getLocalSvg("speedychow_logo"),
      fit: BoxFit.fill,
    );
  }
}
