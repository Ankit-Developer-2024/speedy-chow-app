
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/config/bloc/config_bloc.dart';
import 'package:speedy_chow/features/config/data/repository/config_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async{


  final FlutterLocalization localization = FlutterLocalization.instance;

  //localization
  getIt.registerSingleton(localization);


  //config controller 
   _initConfig();

   //auth bloc
   _initAuthBloc();
}

void _initConfig(){
    getIt.registerLazySingleton<ConfigBloc>(()=>ConfigBloc(configRepoImpl: ConfigRepoImpl()));
}

void _initAuthBloc(){
  print("object");
  getIt.registerFactory<AuthBloc>(()=>AuthBloc());
  print(getIt<AuthBloc>());
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
