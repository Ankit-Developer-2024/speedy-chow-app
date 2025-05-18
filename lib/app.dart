import 'package:flutter/material.dart';
import 'package:speedy_chow/core/routing/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Speedy Chow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     // routeInformationProvider: AppPages.router.routeInformationProvider,
      routerConfig: AppPages.router,
      
    );
  }
}