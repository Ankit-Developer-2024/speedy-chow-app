import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/routing/app_pages.dart';
import 'package:speedy_chow/core/styles/app_theme.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';

import 'init_dependencies.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initFlutterLocalization();
    return BlocBuilder<ConfigBloc, ConfigState>(
      buildWhen: (prev,curr)=> curr is ChangeLanguageState,
      builder: (context, state) {
        if(state is ChangeLanguageState){
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Speedy Chow',
            locale: state.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              // Add other supported locales
            ],
            localizationsDelegates: getIt<FlutterLocalization>()
                .localizationsDelegates,
            theme: AppTheme.lightTheme,
            // routeInformationProvider: AppPages.router.routeInformationProvider,
            routerConfig: AppPages.router,
          );
        }else {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Speedy Chow',
            locale: Locale('en'),
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              // Add other supported locales
            ],
            localizationsDelegates: getIt<FlutterLocalization>()
                .localizationsDelegates,
            theme: AppTheme.lightTheme,
            // routeInformationProvider: AppPages.router.routeInformationProvider,
            routerConfig: AppPages.router,
          );
        }
      },
    );
  }
}