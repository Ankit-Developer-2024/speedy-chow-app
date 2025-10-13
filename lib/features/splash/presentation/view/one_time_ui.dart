import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/splash/domain/use_cases/verfiy_token_use_case.dart';
import 'package:speedy_chow/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:speedy_chow/init_dependencies.dart';

class OneTimeUi extends StatelessWidget {
  const OneTimeUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>SplashBloc(configBloc: getIt<ConfigBloc>(),verifyTokenUseCase: getIt<VerifyTokenUseCase>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  getLocalJpg("splash_bg_image"),
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                ),
                Align(
                  alignment: Alignment(0, 0.8),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 70,
                    height: MediaQuery.sizeOf(context).height / 2,
                    decoration: BoxDecoration(
                      color: AppColors.darkOrange,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius_50,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacing_22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: AppDimensions.spacing_12,
                            children: [
                              Text(
                                AppLocal.whatWeServe.getString(context),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.semiBold27P(
                                  color: AppColors.white,
                                ),
                              ),
                              BlocBuilder<SplashBloc, SplashState>(
                                buildWhen: (prev,curr)=> curr is SplashOneTimeUiState,
                               builder: (context, state) {
                                  if(state is SplashOneTimeUiState){
                                    return IndexedStack(
                                      index: state.introPart,
                                      children: [
                                    Text(
                                    AppLocal.whatWeServeDesc1.getString(
                                    context),
                                 textAlign: TextAlign.center,
                                 style: AppTextStyles.light14P(
                                 color: AppColors.white,
                                 ),
                                 ),
                                 Text(
                                 AppLocal.whatWeServeDesc2.getString(
                                 context),
                                 textAlign: TextAlign.center,
                                 style: AppTextStyles.light14P(
                                 color: AppColors.white,
                                 ),
                                 ),
                                 Text(
                                 AppLocal.whatWeServeDesc3.getString(
                                 context),
                                 textAlign: TextAlign.center,
                                 style: AppTextStyles.light14P(
                                 color: AppColors.white,
                                 ),
                                 )
                                      ],
                                    );
                                  }else {
                                    return Text(
                                      AppLocal.whatWeServeDesc1.getString(
                                          context),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.light14P(
                                        color: AppColors.white,
                                      ),
                                    );
                                  }
                              },
                            ),
                              SizedBox(
                                height: AppDimensions.size_4,
                                child: ListView.separated(
                                  itemCount: 3,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BlocConsumer<SplashBloc, SplashState>(
                                      listenWhen: (pre,curr)=> curr is SplashOneTimeUiCompleteState ,
                                      listener: (context,state){
                                           context.read<ConfigBloc>().add(SetIsAppInstallEvent(true));
                                           context.goNamed(AppRoutes.login) ;
                                      },
                                      buildWhen: (prev,curr)=> curr is SplashOneTimeUiState,
                                      builder: (context, state) {
                                        if( state is SplashOneTimeUiState){
                                          return Container(
                                            width: AppDimensions.size_20,
                                            decoration: BoxDecoration(
                                              color:state.introPart==index ? AppColors.white : AppColors.white.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                AppDimensions.radius_6,
                                              ),
                                            ),
                                          );
                                        } else{
                                          return Container(
                                            width: AppDimensions.size_20,
                                            decoration: BoxDecoration(
                                              color:index==0 ? AppColors.white : AppColors.white.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                AppDimensions.radius_6,
                                              ),
                                            ),
                                          );
                                        }

                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return SizedBox(
                                          width: AppDimensions.spacing_12,
                                        );
                                      },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.read<SplashBloc>().add(
                                    SplashOneTimeUiSkipEvent(),
                                  );
                                },
                                child: Text(
                                  AppLocal.skip.getString(context),
                                  style: AppTextStyles.semiBold14P(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  context.read<SplashBloc>().add(
                                    SplashOneTimeUiEvent(),
                                  );
                                },
                                iconAlignment: IconAlignment.end,
                                label: Text(
                                  AppLocal.next.getString(context),
                                  style: AppTextStyles.semiBold14P(
                                    color: AppColors.white,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.white,
                                  size: AppDimensions.size_16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
