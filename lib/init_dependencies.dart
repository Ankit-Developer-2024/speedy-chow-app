
import 'package:flutter/cupertino.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:speedy_chow/core/components/global_bloc/navigation_bloc.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/config/data/repository/config_repo_impl.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async{


  //getIt.registerSingleton(navigatorKey);

  final FlutterLocalization localization = FlutterLocalization.instance;

  //localization
  getIt.registerSingleton(localization);


  //config controller 
   _initConfig();

  //_initNavigation
  _initNavigationBloc();

  //auth bloc
   _initAuthBloc();

   //home bloc
   _initHomeBloc();

    //cart
   _initCartBloc();

  // profileBloc
   _initProfileBloc();


}

void _initConfig(){
    getIt.registerLazySingleton<ConfigBloc>(()=>ConfigBloc(configRepoImpl: ConfigRepoImpl()));
}

void _initNavigationBloc(){
    getIt.registerLazySingleton<NavigationBloc>(()=>NavigationBloc());
}

void _initAuthBloc(){
  getIt.registerFactory<AuthBloc>(()=>AuthBloc());
}

void _initHomeBloc(){
  getIt.registerFactory<HomeBloc>(()=>HomeBloc());

}

void _initCartBloc(){
  getIt.registerFactory<CartBloc>(()=>CartBloc());
}

void _initProfileBloc(){
  getIt.registerFactory<ProfileBloc>(()=>ProfileBloc());
}

void initFlutterLocalization() {
    getIt<FlutterLocalization>().init(
        mapLocales: [
          MapLocale('en',
              AppLocal.EN,
              countryCode: 'IN',

          )
        ],
        initLanguageCode: 'en');

}
