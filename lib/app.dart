import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/routing/app_pages.dart';

import 'init_dependencies.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    initFlutterLocalization();
    return MaterialApp.router(
      title: 'Speedy Chow',
      supportedLocales: getIt<FlutterLocalization>().supportedLocales,
      localizationsDelegates:getIt<FlutterLocalization>().localizationsDelegates ,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     // routeInformationProvider: AppPages.router.routeInformationProvider,
      routerConfig: AppPages.router,
      
    );
  }
}