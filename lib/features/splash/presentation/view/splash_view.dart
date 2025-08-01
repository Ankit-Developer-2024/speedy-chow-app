import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/splash/domain/use_cases/verfiy_token_use_case.dart';
import 'package:speedy_chow/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:speedy_chow/init_dependencies.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = SplashBloc(configBloc: getIt<ConfigBloc>(),verifyTokenUseCase: getIt<VerifyTokenUseCase>());
     _splashBloc.add(SplashViewCompleteEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _splashBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is ShowOneTimeUiState) {
            context.goNamed(AppRoutes.oneTime);
          } else if (state is ShowLoginViewState) {
            context.goNamed(state.screenName);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.darkOrange,
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(getLocalSvg("speedychow_logo")),
                  Text(AppLocal.speedChow.getString(context),
                    style: AppTextStyles.semiBold27P(color: AppColors.white),),

                ],
              )
          ),
        ),
      ),
    );
  }
}
