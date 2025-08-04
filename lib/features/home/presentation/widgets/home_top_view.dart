import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';

class HomeTopView extends StatelessWidget {
  const HomeTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24,vertical: AppDimensions.spacing_4),
      decoration: BoxDecoration(
          color: AppColors.yellow800,
        image: DecorationImage(image: AssetImage(getLocalPng("home_view_bg")),fit: BoxFit.fill,)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocal.deliveryTo.getString(context),
                    style: AppTextStyles.regular16P(
                      color: AppColors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColors.white,
                    size: AppDimensions.size_24,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.outlined(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding:WidgetStateProperty.all(EdgeInsets.zero) ,
                      minimumSize:WidgetStateProperty.all(Size(32, 32)) ,
                       side: WidgetStateProperty.all(
                        BorderSide(color: AppColors.white),
                      ),
                    ),
                    icon: Icon(
                      Icons.search_rounded,
                      color: AppColors.white,
                      size: AppDimensions.size_20,
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding:WidgetStateProperty.all(EdgeInsets.zero) ,
                      minimumSize:WidgetStateProperty.all(Size(32, 32)) ,
                      side: WidgetStateProperty.all(
                        BorderSide(color: AppColors.white),
                      ),
                    ),
                    icon: Icon(
                      Icons.notifications,
                      color: AppColors.white,
                      size: AppDimensions.size_20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: (){},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimensions.spacing_4,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.white,
                  size: AppDimensions.size_24,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                    MediaQuery.sizeOf(context).width / 2 - 24,
                    minWidth:
                    MediaQuery.sizeOf(context).width / 2 - 24,
                  ),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listenWhen: (prev,curr)=>curr is AuthUserState,
                    listener: (context,state){
                       if(state is AuthUserState){
                         if(state.isSuccess==false && state.isLoading==false){
                           customSnackBar(context, state.message,bgColor: AppColors.red800);
                         }
                       }
                    },
                    buildWhen: (prev,curr)=>curr is AuthUserState,
                    builder: (context, state) {
                      if(state is AuthUserState){

                        if(state.isSuccess){
                          return Text(
                            context.read<AuthBloc>().userModel!=null ? context.read<AuthBloc>().userModel!.email.toString() : "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium16P(
                              color: AppColors.white,
                            ),
                          );
                        }else{
                          return Text("null yy");
                        }
                      }else{
                        return Text("null");
                      }

  },
),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            AppLocal.provideBestFood.getString(context),
            style: AppTextStyles.semiBold27P(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
